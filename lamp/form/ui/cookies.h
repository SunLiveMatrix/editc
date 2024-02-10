//
// Created by admin on 24-2-10.
//

#if 0
#define COOKIES_H

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdarg.h>
#include <string>

QT_BEGIN_NAMESPACE
namespace Ui { class cookies; }
QT_END_NAMESPACE

class cookies : public QWidget {
Q_OBJECT

public:
    explicit cookies(QWidget *parent = nullptr);
    ~cookies() override;

private:
    Ui::cookies *ui;
};

#endif // 0

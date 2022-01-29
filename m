Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7B64A320C
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jan 2022 22:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbiA2VkX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jan 2022 16:40:23 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:33407 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiA2VkW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jan 2022 16:40:22 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MKKIZ-1mxmHb13Pz-00Lj0v; Sat, 29 Jan 2022 22:40:20 +0100
Received: by mail-ot1-f43.google.com with SMTP id i16-20020a056830011000b005a3cc8d20fbso2826089otp.9;
        Sat, 29 Jan 2022 13:40:19 -0800 (PST)
X-Gm-Message-State: AOAM532uGFEAQ/r3avHpRSTjCMnoMLcVBHqAJhysaZqycCFO1YHD+rc3
        KGSt8BekMqCCxzBPyaaoCftp52ERQFwSEyLRg7A=
X-Google-Smtp-Source: ABdhPJxSc4cWbyXoSGQiQtpLi4PNMIRU496vg4S4jN8fyO8Z/BY7E62yNehuKgdWMqyCyzVpdMc329RL2rEKIxjEMaU=
X-Received: by 2002:a9d:73da:: with SMTP id m26mr8391513otk.72.1643492418274;
 Sat, 29 Jan 2022 13:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-4-guoren@kernel.org>
In-Reply-To: <20220129121728.1079364-4-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 29 Jan 2022 22:40:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0jK4quTT6txPakQuuAjyoMXRq1eM35pCFLo0PQNq+p2Q@mail.gmail.com>
Message-ID: <CAK8P3a0jK4quTT6txPakQuuAjyoMXRq1eM35pCFLo0PQNq+p2Q@mail.gmail.com>
Subject: Re: [PATCH V4 03/17] asm-generic: compat: Cleanup duplicate definitions
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lnMfdgYEnSzWgrBdIox1QiTtJ/mhHPon38ownGxPYpb8Uida3VU
 tfyy4FXB2xzzPbBOtGmv5a4pBMEEwyX8O9L1f+kulgNvew7caxFsmKjzWFd+zLH4Fejx5l+
 xassjjrOzMYYfFKqcaxlqyWAWmJ/hygLwuzTj6az5ltiiR6k1hxnFeXy1bEFXbs8GorGkjJ
 zEl1/GLHKvkmvf/pVWmjw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+xAXmlQqFQ0=:q+/YVKL9cK4h9X74Ey2YvJ
 upHTbUlCwlp/hRQIU2bY3zQKgizxwntrROt8rL9SDmbxXt1t9xeiH9gl01IN5lHGQE4F509VY
 PE5BcwOJWst8MWCYFiskFW5fHUP4hpqK1iiLACC8GL/xk+2vq8XvtkypvcwAFSPAhFPCOv5fk
 WEFtf46LfdL1BtGJhTXpo6WAMgzu7+RQiKzGL2fpCWRQHeR/q0pVdgjxZATz0mklQA2ry0rxX
 WlWL2KNZv85yJciTzU3lZ1+olVgzVJ6bW811KHgBuaoNefuqX9MOEZSCaHFnBX/l5gMPdrPll
 51wRPTqB8QRBvnqGZTfMdAHma8C3jx366/Llc5HJpqFmgSMXiAAVDu0zv9bUvRfau/eEbGRIW
 AQYaxk5TgqDdohW4PzPqf4V+OA0jZnTZLhxdCi4CXgwUvqZtqAA/Gk7E+0sIte3LK+65xMZzL
 4hhAefxkz6QTglhcmXDFCozB4OpQqvtX/spngdIDdseRL0Z8Q0j/idC0e1mYPJt/NN9Hs9D/U
 rbReiEIS5pjpCKzzxRoYx7K4b2sP/PXrfr3Iphm6JMwqfvyK5D+DgyFbZieQKdXelPOWdZJIr
 mO1N72L4x2usAHDO3SKhIOq4HzITZIIT1IJFjosHJ1qI6o3/oPvGqMZeCZyN95DuM2YnUirFa
 icB0qacmeX6rA85wW4PTuMQHLsGu69h0doRRlK2XxRu7ZFzzQ/Kww9dT6ZHYkh036G0NhjKTr
 L5JFGyW2RyI8yUnOUh3949XJgOa2HNLfuhUC0YyHnI4HF7fNwJ7dTTebGHwbnZQmq08LP8udI
 KFcvUfXzKU8E0W7uhYGAcWv+bpd1bPXOZ68FA3AaB80qORmrTU=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 29, 2022 at 1:17 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> There are 7 64bit architectures that support Linux COMPAT mode to
> run 32bit applications. A lot of definitions are duplicate:
>  - COMPAT_USER_HZ
>  - COMPAT_RLIM_INFINITY
>  - COMPAT_OFF_T_MAX
>  - __compat_uid_t, __compat_uid_t
>  - compat_dev_t
>  - compat_ipc_pid_t
>  - struct compat_flock
>  - struct compat_flock64
>  - struct compat_statfs
>  - struct compat_ipc64_perm, compat_semid64_ds,
>           compat_msqid64_ds, compat_shmid64_ds
>
> Cleanup duplicate definitions and merge them into asm-generic.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

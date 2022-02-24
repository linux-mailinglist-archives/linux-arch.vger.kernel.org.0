Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13D24C283D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 10:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiBXJif (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 04:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiBXJic (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 04:38:32 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84F27AFEB;
        Thu, 24 Feb 2022 01:38:01 -0800 (PST)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M5wgF-1nK8Z23HC7-007VzJ; Thu, 24 Feb 2022 10:37:59 +0100
Received: by mail-wr1-f41.google.com with SMTP id d3so2036952wrf.1;
        Thu, 24 Feb 2022 01:37:59 -0800 (PST)
X-Gm-Message-State: AOAM531mren4RcSI9hV+ys6vEYPD16bM3U00jfR/pAxKIYZAZm98re8m
        sYWDOeFLPebeWg1AsQSNW6vrEAmxCpcYwTo4kUg=
X-Google-Smtp-Source: ABdhPJxKnbR5fQtLrHkUQmPSDD+xkHkCuZRWZe5PlaQucJaWZYHMl1I+Wr1dE0VfS6g2+fYVY4BPWlfD5Z76idC1Sco=
X-Received: by 2002:adf:a446:0:b0:1ed:c41b:cf13 with SMTP id
 e6-20020adfa446000000b001edc41bcf13mr1559929wra.407.1645695092672; Thu, 24
 Feb 2022 01:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20220224085410.399351-1-guoren@kernel.org> <20220224085410.399351-12-guoren@kernel.org>
In-Reply-To: <20220224085410.399351-12-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 24 Feb 2022 10:31:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3wg9S_zPad74FiJzYBn0M9bQyunuKzmH3z_QQrags5ng@mail.gmail.com>
Message-ID: <CAK8P3a3wg9S_zPad74FiJzYBn0M9bQyunuKzmH3z_QQrags5ng@mail.gmail.com>
Subject: Re: [PATCH V6 11/20] riscv: compat: syscall: Add compat_sys_call_table
 implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
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
X-Provags-ID: V03:K1:bJ949jbvxqRzT8RGzj2QYrApGMZ4GN1YTokJ4Yg5/VzjO8Su2uE
 ipDUtwaeK0DeWGhdUHDvGS6Sxk+PjnIWHXHqM03B+4KiJMsbfQObb3/g4Rb9ehoxvIs7pAb
 3xXOC8l0NvUVW3TdDOlDdrw1fIEzH5Ue8s6u34x3GpIf/5gKusINz0fsj5g7jSQKQJXAUDd
 y9XhStiamjcfDraOeAP7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dwAfY9Ku57I=:6NKueo92cdx8lj+82OAOD5
 ulk+zylPDzaUxvVUzhJpGKLU7YiwrMbf7G25DHOirZgFEmfxwc51w1cNxnsmQoii7jX4pKE9a
 dOWn1HvOs9fUNtoNQWaUf6U5ViEPhWvXToLKi75vietmj9uC2QxIhS9ILo41p/hUYLeohsWLi
 QW3aBB9AkASEmnIngeLwpWY+LBUdXglk0GELcd0a9C64Z3xmOPX5z49YIhjhE/+ipUePv9/Mq
 L/wWPiJVTMI+eTWTZnFDha0SQ36pExEHntKrTD8b3P7GrhFFSWpMd8i3aaNiERV4x/dmZc7KA
 Xajt3CIeWflvcnXlqYtKI6eLK+u2Yg7/sONFg09gKfBZXPPFSyIHk4bk3KJ2aRp3jQ0rF8ZlV
 de19TTPXXdwa9hU0N+l3/3witYzOHCSzIPDU4lXVHpZZDzJG/jSIbFD2MQlV++ca1+a17mzqc
 /6UCJicm2Xi17UtwaSrGAeOT59ng+WIj0a49UoTHKszzP1ncpwQ13Nn8mepUQWmL8G9BfJ4X0
 DWlaIYLO+Pyr27exsf0sJXXIi0X65UtJNwfibrp0k9Ndu9c7gkYfV/8FDPNuGwgJwcK1/2esS
 YoEFouJd8FgXwxvGs8Wr5xQW2GP7glUv0vaYWhu7E8/Mfn7sZv4npXBf5/RZ0Ra/KvvUkTmuG
 sm+FpxMPUaxs6Mm/tLff2FLkzRLOsYnhal2ZVxJS3hUWmchiqOL0uooT7u/1Md8xTaUmHnRyh
 bxASaOLsX+ezzHOQykOOAFFi/5kM2dl9mVM+CEUm4q/Ufr17oj0n8OR9SEB7cw1ZPlIYj2BQT
 qQFtiThCNHUgBuJwQw+98J/orUmUlwXXAyK6PN24WjEYj81+4s=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 24, 2022 at 9:54 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Implement compat sys_call_table and some system call functions:
> truncate64, ftruncate64, fallocate, pread64, pwrite64,
> sync_file_range, readahead, fadvise64_64 which need argument
> translation.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>

Here, I was hoping you'd convert some of the other architectures to use
the same code, but the changes you did do look correct.

Please at least add the missing bit for big-endian architectures here:

+#if !defined(compat_arg_u64) && !defined(CONFIG_CPU_BIG_ENDIAN)
+#define compat_arg_u64(name)           u32  name##_lo, u32  name##_hi
+#define compat_arg_u64_dual(name)      u32, name##_lo, u32, name##_hi
+#define compat_arg_u64_glue(name)      (((u64)name##_hi << 32) | \
+                                        ((u64)name##_lo & 0xffffffffUL))
+#endif

with the lo/hi words swapped. With that change:

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

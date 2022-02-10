Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690E74B09B2
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 10:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbiBJJjs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 10 Feb 2022 04:39:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiBJJjs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 04:39:48 -0500
X-Greylist: delayed 102 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 01:39:49 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88AA220;
        Thu, 10 Feb 2022 01:39:48 -0800 (PST)
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M3Eqr-1nJSJC0kQ9-003h6D; Thu, 10 Feb 2022 10:39:47 +0100
Received: by mail-wm1-f45.google.com with SMTP id i19so1652570wmq.5;
        Thu, 10 Feb 2022 01:39:47 -0800 (PST)
X-Gm-Message-State: AOAM531cb0eqtPrq/hCj9B/hPBhQNdci/UadveB7HA3H/hnCgUdoURyD
        GycahrxyX7E3dkwlbQAmsYFFmtQe7P7Nov0WHIk=
X-Google-Smtp-Source: ABdhPJzUBE9AmHKtA86Xv3LRiM760+wqDeJhZfBxDNdjYz5WjMMMxnuXS2W7stLYFq1NMZvK6WNceMm+VXnOfCsZ8qY=
X-Received: by 2002:a05:600c:1f06:: with SMTP id bd6mr1419523wmb.98.1644485986746;
 Thu, 10 Feb 2022 01:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20220210021129.3386083-1-masahiroy@kernel.org> <20220210021129.3386083-3-masahiroy@kernel.org>
In-Reply-To: <20220210021129.3386083-3-masahiroy@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Feb 2022 10:39:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1qbAXeKuuswuCSmMqC8k4wC-uQZqjiSd8WsFuqM906MA@mail.gmail.com>
Message-ID: <CAK8P3a1qbAXeKuuswuCSmMqC8k4wC-uQZqjiSd8WsFuqM906MA@mail.gmail.com>
Subject: Re: [PATCH 2/6] shmbuf.h: add asm/shmbuf.h to UAPI compile-test coverage
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:jyMslo3fNya4WydPD3YHn1XYJyEHge1unk7I3p/UHh5+V+hBae5
 wgwCe5jLJ7oH/GBSFMm+AzIAUuyxeWRUzleqR1Kg4VjxdY+wUtO2cBkAWo80I7QcJR0QdGC
 SSd23Vwu7H9HxnW/jJg5UFRzKhoTzz9XFoJLe1u8gcCE3xFYjAY9CpYgp88mhorTOTzoOgt
 C9plEZhksApmrn2eQq4nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qkRBoUw9+k8=:lXxLoYCwEmC9akTlT8jJQI
 6kbqoGW9UuaUcSJ1ZBgsrj8IPjccg4OIYivU0eoXpC7uAzD+JtBooH1dxwvvUuaof27+GU8Y+
 6LgmrIXEVHL7B7rmhM+AHKQVhFtaor6+NLv9FFVKOBJnuj8DqfvZQnv9XXR2SSlZegoqK7YrP
 /gHmqkNruerBOpcrU0GWwvBfqMjydhwiT7ImPkmcU8E8A9zSPJnuZXOE3T4KDUR4z7M/T8Etj
 nU4Nhn5kPWo4Ea87WOVjRnG7KQvevb8xS9Uy8YgHJrcmGJE9MSEkp4GPGCH1r48+cO4CPSCB2
 OVJrNoaBdZBjlX/r4IqO2WO9cZgiHLLJV7wNcOukIaxTISzF29vTvq6PVZCqgBurxWbk2w1MH
 0HtDCM5j/INvXcnlL663pl5mTD83RZNSZlMBk/xj7A6sUqRbY4EibnVCBXZAI/0Mr1hc3PlE/
 m56xyLVy36Gz42Kf2qZY9wyXp7EUw/HheO2JvckLkm1BTT9QhF85BUfezhmGlqHFXU3U/jcCj
 CMSzU7vBA2pRSpsA7XRMluWEpVU8ZWU6X2l3koizq7OZ5wSf2kcRoJThd9tuILN8OPhPv05GY
 V8BIe5KgdDpz100hFhtOnejFtUYaYj19GyHrzBddHTvmajCQeqH8GyjNyupFfMZg3+x7RrU0n
 TR9qFV6tQXktJLcrSrswbQTU1t+gFLqmdN0iiwXSx8B2gSyErTiHpII7BKvm/Biif511qU6z1
 rR0OBWlvI4GY55v2t5sCYm0FOtOXqV5j3GVr++TuPZkteqBeKLOGSdkE0LUv8E0fJT5hcbd6V
 imjiOhtcrki+7JriX/1dlX488JJ2humobMlx0Ww+tCMCgDdMjU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 3:11 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> asm/shmbuf.h is currently excluded from the UAPI compile-test because of
> the errors like follows:
>
>     HDRTEST usr/include/asm/shmbuf.h
>   In file included from ./usr/include/asm/shmbuf.h:6,
>                    from <command-line>:
>   ./usr/include/asm-generic/shmbuf.h:26:33: error: field ‘shm_perm’ has incomplete type
>      26 |         struct ipc64_perm       shm_perm;       /* operation perms */
>         |                                 ^~~~~~~~
>   ./usr/include/asm-generic/shmbuf.h:27:9: error: unknown type name ‘size_t’
>      27 |         size_t                  shm_segsz;      /* size of segment (bytes) */
>         |         ^~~~~~
>   ./usr/include/asm-generic/shmbuf.h:40:9: error: unknown type name ‘__kernel_pid_t’
>      40 |         __kernel_pid_t          shm_cpid;       /* pid of creator */
>         |         ^~~~~~~~~~~~~~
>   ./usr/include/asm-generic/shmbuf.h:41:9: error: unknown type name ‘__kernel_pid_t’
>      41 |         __kernel_pid_t          shm_lpid;       /* pid of last operator */
>         |         ^~~~~~~~~~~~~~
>
> The errors can be fixed by replacing size_t with __kernel_size_t and by
> including proper headers.
>
> Then, remove the no-header-test entry from user/include/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

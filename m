Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A64B09D0
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 10:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiBJJqL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 04:46:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238777AbiBJJqL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 04:46:11 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9931A19B;
        Thu, 10 Feb 2022 01:46:12 -0800 (PST)
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N4z2a-1oGPo62Bqm-010wgz; Thu, 10 Feb 2022 10:46:10 +0100
Received: by mail-wr1-f54.google.com with SMTP id m14so8409986wrg.12;
        Thu, 10 Feb 2022 01:46:10 -0800 (PST)
X-Gm-Message-State: AOAM530DjWZ/6dciD1ZMv+DeDBCoINrNbiAANWKZ9LtbtEtI12J6bceL
        ugullxZ8wKTOzNrtWWnvfFW5RmxjbyZpB8tFMKg=
X-Google-Smtp-Source: ABdhPJxcpQFyag0KwSELzBj9ldE+qSL1/H/9t/X1/IgTrmi6bmIj3+YDSYUbn2Cst0fnVEDT6DYwWrIQLi2F7dpyEWc=
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr707156wrn.317.1644486370130;
 Thu, 10 Feb 2022 01:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20220210021129.3386083-1-masahiroy@kernel.org>
In-Reply-To: <20220210021129.3386083-1-masahiroy@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Feb 2022 10:45:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3uZJuf9naTerxMdUeW4CEuvfK0knC0JDTZteYHPqddTw@mail.gmail.com>
Message-ID: <CAK8P3a3uZJuf9naTerxMdUeW4CEuvfK0knC0JDTZteYHPqddTw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add more export headers to compile-test coverage
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1x4Cb7skvs1UW7XhHMLHn2O2tD5ZgZyMngr8pVLVHJJbQ/OTYnN
 FIwlJO3ODsMjMXnOmebowYnbCii/sQHJvfQZqmDL+OLRc86kV1PwMAO8ujA3aqXeRuQDiK+
 Nz4NfZIr4d9EByy0GUVhMg4amB/Fl9sR7voshB1VgKsTRFZF4jpVZPj5tExwdOS03ay+aPM
 fwx1f3iRxh8ncxmNxzAUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/W4Cj46B6kQ=:KIJx7QwTj9KsemFdmuXi9P
 TnH/0zulKv4LW9PJFWg+mbj3xoRgTJQwzw+ZQ66mIHSlV+2bld16OJuNr4ab97DRsx04FKHjZ
 dO9xmGzCHSKUdK9rBpArTFvu/5qDUujNFbcnJGn28jnYXodC0bq/41FFpnFNUD+HX0Svv46Pu
 zB2Zb/6xqqzF3qsk/YJnr1X97lGEbvOxprdusZoREgisuNkE6vArFFEYNvwM51arA/p9mNr4L
 xPn1+xCFd+RCWA8m0LQP/gDBJp9Yh5/rFUVDBDWipZoK2of1z5nIP3S1hrzFbQGM/VXwDONHj
 O/whNtVu6AlTFf+v3DHuE/ewgrmxRb02hVBZqWiaX3Vzb3SWimVL/swRcvml2V3A5F35/laqG
 YI3FTZDhF4i18fja8FGSjewzoMpnRYBIGZRMYVLo+U+ANuhhzeHXTqEXoA4PQKVQh7YewVS3X
 HGVmZMWboZzOxaJUsfnyjICE9nGMmiwDRQVHfb1jCxWt0fcBEzsDFmtdkA+R1PDcx3aDX5PXS
 TrmJGZlCHVGjjwhGCxuhPgaUOf23IJHc/vC6ez/AwgkKvLptJbWMe2PrgxDwz5BZPogeAQUkj
 9MOu5wGCN3FOtkn3A+cexFxmxPvKKnHtF5WShUaBE99/0vxavJdB9Wi29bEaaqziIEatiylx4
 waHj/0mQXymFJhO75Z374PM9L5+EC4+2qZbYQeAnqbsF67teU8TWdNpF+cbgSNO6RtdthbyPU
 bPcAjlZ4nFqokjHz1EwN6m+RzlhBvTboXFKcUBIhdRj26JtjZKDSHEC/bZTP0bvzhyi7H9Gj7
 UJws6hJ7htI7HRGJbQOHWLnT63RNqKKCX5NzA96WdaGw2pDD1s=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 3:11 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> Masahiro Yamada (6):
>   signal.h: add linux/signal.h and asm/signal.h to UAPI compile-test
>     coverage
>   shmbuf.h: add asm/shmbuf.h to UAPI compile-test coverage
>   android/binder.h: add linux/android/binder(fs).h to UAPI compile-test
>     coverage
>   fsmap.h: add linux/fsmap.h to UAPI compile-test coverage
>   kexec.h: add linux/kexec.h to UAPI compile-test coverage
>   reiserfs_xattr.h: add linux/reiserfs_xattr.h to UAPI compile-test
>     coverage

Very nice! Should I pick these up into the asm-generic tree?

      Arnd

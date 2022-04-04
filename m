Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03924F107E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 10:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377903AbiDDIG3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 04:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377907AbiDDIG2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 04:06:28 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8BC31DF6;
        Mon,  4 Apr 2022 01:04:30 -0700 (PDT)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 234848bo021121;
        Mon, 4 Apr 2022 17:04:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 234848bo021121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649059448;
        bh=4V3S2537hEXTRhH8SIRp0YPIm1iUoX+tEHBAKXGY68M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0UIw8fYLrhR0X3roP/bYNwzjan97ZWnMOxdXYxZvD42TUakyAUI+iLhbvmbHqYrHc
         2tSM0DfxEvwvJMjaf+ZNg0xv7i4dKyLLgjcC65VoZVzMiTkSEmNQWby5AH5m278KkU
         ss6Uv28unkF+M15Ua9pO3/knh/Fbre6QyJgzLHv5JDqQkCDPYxeGKCIgWmRWHPPhNP
         bfPTx5vLgfEhklrhE+FY6wbHyHx5GRH1+6HeE1Xv9H1nXosUW0jAjWpL07LOiY+UjL
         2vY7INSuvaNAhvbb/JcwhkpIQed3B9qN9aqsFLEOeSQEEeo1NHiaOsHq1PNMnbCscr
         JVu9Tg4JmJcGQ==
X-Nifty-SrcIP: [209.85.210.182]
Received: by mail-pf1-f182.google.com with SMTP id h24so3898406pfo.6;
        Mon, 04 Apr 2022 01:04:08 -0700 (PDT)
X-Gm-Message-State: AOAM531g642i0bb9J0ClVaLo+NCPrfjcxV+hHByBFb90tuBd8sPd/cOO
        2GJ5PgYRZgys1EwTWi8O8aq76sU9s+3vB5p7pC4=
X-Google-Smtp-Source: ABdhPJwROPwMLFJgN+ysWt1cOvjuJ5+JIqqWq/foMxeHpnlqqCk2ZxYCccbwbY56dSUxd2aMlrlgPCt4S9gRJud88wA=
X-Received: by 2002:a63:dc53:0:b0:381:7f41:3a2d with SMTP id
 f19-20020a63dc53000000b003817f413a2dmr25224550pgj.126.1649059447687; Mon, 04
 Apr 2022 01:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-3-masahiroy@kernel.org> <YkqhQhJIQEL2qh8C@infradead.org>
In-Reply-To: <YkqhQhJIQEL2qh8C@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 4 Apr 2022 17:03:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNATecXbEZZCxb3p9hBe7wHsLkhpavELCFbX7=ZM2hTV7sg@mail.gmail.com>
Message-ID: <CAK7LNATecXbEZZCxb3p9hBe7wHsLkhpavELCFbX7=ZM2hTV7sg@mail.gmail.com>
Subject: Re: [PATCH 2/8] kbuild: prevent exported headers from including
 <stdlib.h>, <stdbool.h>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 4, 2022 at 4:41 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Apr 04, 2022 at 03:19:42PM +0900, Masahiro Yamada wrote:
> > If we can make kernel headers self-contained (that is, none of exported
> > kernel headers includes system headers), we will be able to add the
> > -nostdinc flag, but that is much far from where we stand now.
>
> What is still missing for that?


I changed as follows:

diff --git a/usr/include/Makefile b/usr/include/Makefile
index fa9819e022b7..169fca1a0f28 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -15,7 +15,7 @@ UAPI_CFLAGS += $(filter -m32 -m64 --target=%,
$(KBUILD_CFLAGS))
 # USERCFLAGS might contain sysroot location for CC.
 UAPI_CFLAGS += $(USERCFLAGS)

-override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
+override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile)
-I$(objtree)/usr/include -nostdinc

 # The following are excluded for now because they fail to build.
 #




I got this:



masahiro@grover:~/ref/linux$ make -j8 allyesconfig usr/include/
#
# No change to .config
#
  DESCEND objtool
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  HDRTEST usr/include/linux/wireless.h
  HDRTEST usr/include/linux/atmlec.h
  HDRTEST usr/include/linux/if_fc.h
  HDRTEST usr/include/linux/iso_fs.h
  HDRTEST usr/include/linux/sysinfo.h
  HDRTEST usr/include/linux/un.h
  HDRTEST usr/include/linux/ax25.h
  HDRTEST usr/include/linux/map_to_14segment.h
In file included from ./usr/include/linux/wireless.h:75,
                 from <command-line>:
./usr/include/linux/if.h:28:10: fatal error: sys/socket.h: No such
file or directory
   28 | #include <sys/socket.h>                 /* for struct
sockaddr.         */
      |          ^~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [usr/include/Makefile:101:
usr/include/linux/wireless.hdrtest] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:550: usr/include] Error 2
make[1]: *** [Makefile:1834: usr] Error 2
make: *** [Makefile:350: __build_one_by_one] Error 2










-- 
Best Regards
Masahiro Yamada

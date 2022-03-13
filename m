Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567F24D7441
	for <lists+linux-arch@lfdr.de>; Sun, 13 Mar 2022 11:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiCMKjA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Mar 2022 06:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiCMKjA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Mar 2022 06:39:00 -0400
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Mar 2022 03:37:49 PDT
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82D0010CD;
        Sun, 13 Mar 2022 03:37:49 -0700 (PDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id ACEE272C907;
        Sun, 13 Mar 2022 13:28:26 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 9F23F7CE0CA; Sun, 13 Mar 2022 13:28:26 +0300 (MSK)
Date:   Sun, 13 Mar 2022 13:28:26 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] signal.h: add linux/signal.h and asm/signal.h to
 UAPI compile-test coverage
Message-ID: <20220313102826.GB28782@altlinux.org>
References: <20220210021129.3386083-1-masahiroy@kernel.org>
 <20220210021129.3386083-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220210021129.3386083-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 11:11:24AM +0900, Masahiro Yamada wrote:
> linux/signal.h and asm/signal.h are currently excluded from the UAPI
> compile-test because of the errors like follows:
> 
>     HDRTEST usr/include/asm/signal.h
>   In file included from <command-line>:
>   ./usr/include/asm/signal.h:103:9: error: unknown type name ‘size_t’
>     103 |         size_t ss_size;
>         |         ^~~~~~
> 
> The errors can be fixed by replacing size_t with __kernel_size_t.
> 
> Then, remove the no-header-test entries from user/include/Makefile.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

This is essentially the same patch as
https://lore.kernel.org/lkml/20211228155429.GA11957@altlinux.org/

Apparently, some people are more lucky in getting their patches reviewed.

Anyway,
Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>


-- 
ldv

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425BE5B699A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Sep 2022 10:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiIMIcZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Sep 2022 04:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiIMIcY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Sep 2022 04:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B42532BAE;
        Tue, 13 Sep 2022 01:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA5C961348;
        Tue, 13 Sep 2022 08:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7B2C433C1;
        Tue, 13 Sep 2022 08:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663057942;
        bh=IpBWenXYeupRmjxDDsPlTF+3obS82kk1lpWQuCco5+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfPiTmaohwaNWsD/cBAWS0LdnmTZ7deyI3x2T0JSUPyITOTySPDNC8cNMVXQ4+JRs
         YIl8lx7Ta1yRVaM5lSiDyew/bJiY64qWTfNYUsMe/kQVQsMOSAtfsTN9CJ+aq3WlA6
         AUYQz8v5PiSfAm0MhYmHG0GE6/2Ku5UlSbRkc5CDlW/zbAPwo3Tdoutbd9mVhdKLbp
         E/nlthrWW+nJ5+ZdeKacqQMW1ca7k+BcVHXreftNkFKZ4XaD2jc0SbzPaTHzrVS4LI
         G0yHd1gqsN7kn2B7vEClRdoQbD96JLqkc69vRQA0njFpQiQ6j60HsgWlPjECQ2k/m/
         CetHM6rZXmCww==
Date:   Tue, 13 Sep 2022 01:32:20 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 05/15] kbuild: build init/built-in.a just once
Message-ID: <YyBAFL9CBsM9gl38@dev-arch.thelio-3990X>
References: <20220828024003.28873-1-masahiroy@kernel.org>
 <20220828024003.28873-6-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828024003.28873-6-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Masahiro,

On Sun, Aug 28, 2022 at 11:39:53AM +0900, Masahiro Yamada wrote:
> Kbuild builds init/built-in.a twice; first during the ordinary
> directory descending, second from scripts/link-vmlinux.sh.
> 
> We do this because UTS_VERSION contains the build version and the
> timestamp. We cannot update it during the normal directory traversal
> since we do not yet know if we need to update vmlinux. UTS_VERSION is
> temporarily calculated, but omitted from the update check. Otherwise,
> vmlinux would be rebuilt every time.
> 
> When Kbuild results in running link-vmlinux.sh, it increments the
> version number in the .version file and takes the timestamp at that
> time to really fix UTS_VERSION.
> 
> However, updating the same file twice is a footgun. To avoid nasty
> timestamp issues, all build artifacts that depend on init/built-in.a
> must be atomically generated in link-vmlinux.sh, where some of them
> do not need rebuilding.
> 
> To fix this issue, this commit changes as follows:
> 
> [1] Split UTS_VERSION out to include/generated/utsversion.h from
>     include/generated/compile.h
> 
>     include/generated/utsversion.h is generated just before the
>     vmlinux link. It is generated under include/generated/ because
>     some decompressors (s390, x86) use UTS_VERSION.
> 
> [2] Split init_uts_ns and linux_banner out to init/version-timestamp.c
>     from init/version.c
> 
>     init_uts_ns and linux_banner contain UTS_VERSION. During the ordinary
>     directory descending, they are compiled with __weak and used to
>     determine if vmlinux needs relinking. Just before the vmlinux link,
>     they are compiled without __weak to embed the real version and
>     timestamp.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

<snip>

> diff --git a/init/build-version b/init/build-version
> new file mode 100755
> index 000000000000..39225104f14d
> --- /dev/null
> +++ b/init/build-version
> @@ -0,0 +1,10 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +VERSION=$(cat .version) 2>/dev/null &&
> +VERSION=$(expr $VERSION + 1) 2>/dev/null ||
> +VERSION=1
> +
> +echo ${VERSION} > .version
> +
> +echo ${VERSION}

I am seeing

  cat: .version: No such file or directory

at some point in nearly all of my builds in -next. Does the 2>/dev/null
want to be moved into the subshell?

Cheers,
Nathan

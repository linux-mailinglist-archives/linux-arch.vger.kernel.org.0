Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A09D499D2E
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 23:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352294AbiAXWQu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jan 2022 17:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576941AbiAXV5C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jan 2022 16:57:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677E7C038AE1;
        Mon, 24 Jan 2022 12:38:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48FAA61540;
        Mon, 24 Jan 2022 20:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7052C340EC;
        Mon, 24 Jan 2022 20:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643056700;
        bh=l7cvZgIsIwqv4LAC60bKrfGQYbIF6mK9Jif6GEmnsdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1X8vk3LKgVfUy7Kw+UryhTphoi9IbtbvcpEFh+TsjwcQM5gsT/1cRF6QT1mvpDi5
         +UFp9wwyd5No619fazpvWgRoNWwhxIhNU7kjoCdbhN9Iewa7vGOPmIQp/DdNYJMejk
         /ofSQmlsnouHl/1ce6SimQ/07ngoCIriRroMgsvN9I245Gl9l9gpqfDpgr3SAVivw0
         RWi9j96uvlmEpZr9KwqA76aJLLfhBOT9VqDMuFZP8++jeEEvurhEzku1pCXtNKx03S
         UEFYN5lHXLCg/yQmemvyJnwTVbnAvWcp5+V6w2uVbBLH0ETDrdSBYOX3QwYwkWd8cE
         uleuvYJi+lodQ==
Date:   Mon, 24 Jan 2022 14:45:04 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        carnil@debian.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] Revert "Makefile: Do not quote value for
 CONFIG_CC_IMPLICIT_FALLTHROUGH"
Message-ID: <20220124204504.GB11735@embeddedor>
References: <20220120053100.408816-1-masahiroy@kernel.org>
 <CAKwvOd=52G2J2nXRbefjJ57B_ySZaZ6SD8UwwHziZMPoR6ABHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=52G2J2nXRbefjJ57B_ySZaZ6SD8UwwHziZMPoR6ABHQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 24, 2022 at 11:55:43AM -0800, Nick Desaulniers wrote:
> + Salvatore, Kees, Gustavo, Nathan
> 
> On Wed, Jan 19, 2022 at 9:31 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > This reverts commit cd8c917a56f20f48748dd43d9ae3caff51d5b987.
> >
> > Commit 129ab0d2d9f3 ("kbuild: do not quote string values in
> > include/config/auto.conf") provided the final solution.
> >
> > Now reverting the temporary workaround.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Great!

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> 
> > ---
> >
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 3f07f0f04475..c94559a97dca 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -778,7 +778,7 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
> >  KBUILD_CFLAGS += $(stackp-flags-y)
> >
> >  KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
> > -KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH:"%"=%)
> > +KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
> >
> >  ifdef CONFIG_CC_IS_CLANG
> >  KBUILD_CPPFLAGS += -Qunused-arguments
> > --
> > 2.32.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers

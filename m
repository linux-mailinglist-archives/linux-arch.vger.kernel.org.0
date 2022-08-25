Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08085A088F
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 07:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiHYF5S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 01:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiHYF5R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 01:57:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95499F197;
        Wed, 24 Aug 2022 22:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DF82B826A7;
        Thu, 25 Aug 2022 05:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E63CC433C1;
        Thu, 25 Aug 2022 05:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661407032;
        bh=BzxcFbEfQ/Yeo0E0e2sHS9CwVB1n9JHMHeKD1IhcYQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEt6QVjfJvyXaIx6HafON24CGsg9kBIx410clN6sJBNxvMYqYT3t69Qvv8fUydCii
         VOwmEd+zP/S8e5fTVek0cwEzoI7qPe3LRWV7/keV37Vli2wwYtB4pRJJqPwFYcThG8
         Wop0557JL/SJdBKCbpMCKDMgvC3WMpgcPTgoiaFA=
Date:   Thu, 25 Aug 2022 07:57:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alex Colomar <alx@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
Message-ID: <YwcPQ987poRYjfoL@kroah.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 25, 2022 at 01:36:10AM +0200, Alejandro Colomar wrote:
> But from your side what do we have?  Just direct NAKs without much
> explanation.  The only one who gave some explanation was Greg, and he
> vaguely pointed to Linus's comments about it in the past, with no precise
> pointer to it.  I investigated a lot before v2, and could not find anything
> strong enough to recommend using kernel types in user space, so I pushed v2,
> and the discussion was kept.

So despite me saying that "this is not ok", and many other maintainers
saying "this is not ok", you applied a patch with our objections on it?
That is very odd and a bit rude.

> I would like that if you still oppose to the patch, at least were able to
> provide some facts to this discussion.

The fact is that the kernel can not use the namespace that userspace has
with ISO C names.  It's that simple as the ISO standard does NOT
describe the variable types for an ABI that can cross the user/kernel
boundry.

Work with the ISO C standard if you wish to document such type usage,
and get it approved and then we would be willing to consider such a
change.  But until then, we have to stick to our variable name types,
just like all other operating systems have to (we are not alone here.)

Please revert your change.

greg k-h

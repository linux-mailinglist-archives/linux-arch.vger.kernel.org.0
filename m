Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD467B77A4
	for <lists+linux-arch@lfdr.de>; Wed,  4 Oct 2023 08:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjJDGLS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Oct 2023 02:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjJDGLR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2023 02:11:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A6AD;
        Tue,  3 Oct 2023 23:11:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27838C433C8;
        Wed,  4 Oct 2023 06:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696399874;
        bh=rALAYhGQmJyIirMMRNk2TTp+3BBfkrtdrx8C7W4qdw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i51R0wVzA2sf7Y9M68lYyzEygs8eHLfNW/lGCwRQOXvbqtgvE6UV4HzPymji571NQ
         A80ODPwQoC7tzhbnnusmSVhXXp/ahpzHKA7xnYgbWz1UUq0co4bO5sBxku3T6kdyIy
         jULjlCqgyhIGfmofQJyKGmOAxkQ6VplOzgS/DSSE=
Date:   Wed, 4 Oct 2023 08:11:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Message-ID: <2023100458-confusing-carton-3302@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093057-eggplant-reshoot-8513@gregkh>
 <ZRia1uyFfEkSqmXw@liuwe-devbox-debian-v2>
 <2023100154-ferret-rift-acef@gregkh>
 <ZRyj5kJJYaBu22O3@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRyj5kJJYaBu22O3@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 03, 2023 at 11:29:42PM +0000, Wei Liu wrote:
> > > > > diff --git a/include/uapi/hyperv/hvgdk.h b/include/uapi/hyperv/hvgdk.h
> > > > > new file mode 100644
> > > > > index 000000000000..9bcbb7d902b2
> > > > > --- /dev/null
> > > > > +++ b/include/uapi/hyperv/hvgdk.h
> > > > > @@ -0,0 +1,41 @@
> > > > > +/* SPDX-License-Identifier: MIT */
> > > > 
> > > > That's usually not a good license for a new uapi .h file, why did you
> > > > choose this one?
> > > > 
> > > 
> > > This is chosen so that other Microsoft developers who don't normally
> > > work on Linux can review this code.
> > 
> > Sorry, but that's not how kernel development is done.  Please fix your
> > internal review processes and use the correct uapi header file license.
> > 
> > If your lawyers insist on this license, that's fine, but please have
> > them provide a signed-off-by on the patch that adds it and have it
> > documented why it is this license in the changelog AND in a comment in
> > the file so we can understand what is going on with it.
> > 
> 
> We went through an internal review with our legal counsel regarding the
> MIT license. We have an approval from them.
> 
> Let me ask if using something like "GPL-2.0 WITH Linux-syscall-note OR
> MIT" is possible.

That marking makes no sense from a legal point of view, please work with
your lawyers as it seems they do not understand license descriptions
very well :(

thanks,

greg k-h

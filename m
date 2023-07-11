Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B474F40E
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 17:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjGKPuB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 11:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGKPuB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 11:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D14BF0;
        Tue, 11 Jul 2023 08:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3103D61515;
        Tue, 11 Jul 2023 15:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63951C433C7;
        Tue, 11 Jul 2023 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689090599;
        bh=1M8nmB54EZY/+b8my3a6BRvNuquZWY4tkJH0mqxJC+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BoKijjfvqvv6NbUyE/VuntEq0ELyssdgeVkybVbYFPfbtEz1VefthvwapIjaumpVB
         +PbmD9siI2vBoZVtSyejupQbkm7KVC1DthD2GDhKgPSjvUiPxtwYJQ5vZS62Luf/l9
         4Pq5qrGeuQ6KnzuOpBqfi3YC2uJTfLDukkZrp3zo=
Date:   Tue, 11 Jul 2023 08:49:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/38] minmax: Add in_range() macro
Message-Id: <20230711084958.8fdbb0fc4f80c6d9bbaf0ca3@linux-foundation.org>
In-Reply-To: <ZKy7FIhozutiOaSm@casper.infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
        <20230710204339.3554919-2-willy@infradead.org>
        <20230710161341.c8d6a8b2cbf57013bf6e0140@linux-foundation.org>
        <ZKy7FIhozutiOaSm@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 11 Jul 2023 03:14:44 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Jul 10, 2023 at 04:13:41PM -0700, Andrew Morton wrote:
> > > +/**
> > > + * in_range - Determine if a value lies within a range.
> > > + * @val: Value to test.
> > > + * @start: First value in range.
> > > + * @len: Number of values in range.
> > > + *
> > > + * This is more efficient than "if (start <= val && val < (start + len))".
> > > + * It also gives a different answer if @start + @len overflows the size of
> > > + * the type by a sufficient amount to encompass @val.  Decide for yourself
> > > + * which behaviour you want, or prove that start + len never overflow.
> > > + * Do not blindly replace one form with the other.
> > > + */
> > > +#define in_range(val, start, len)					\
> > > +	sizeof(start) <= sizeof(u32) ? in_range32(val, start, len) :	\
> > > +		in_range64(val, start, len)
> > 
> > There's nothing here to prevent callers from passing a mixture of
> > 32-bit and 64-bit values, possibly resulting in truncation of `val' or
> > `len'.
> > 
> > Obviously caller is being dumb, but I think it's cost-free to check all
> > three of the arguments for 64-bitness?
> > 
> > Or do a min()/max()-style check for consistently typed arguments?
> 
> How about
> 
> #define in_range(val, start, len)					\
> 	(sizeof(val) | sizeof(start) | size(len)) <= sizeof(u32) ?	\
> 		in_range32(val, start, len) : in_range64(val, start, len)

It saves some typing ;)   sizeof(val+start+len)?  <no>





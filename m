Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205E1286813
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 21:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgJGTJg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 15:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJGTJg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 15:09:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2DEC061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 12:09:36 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQEod-0018nC-25; Wed, 07 Oct 2020 21:09:31 +0200
Message-ID: <661d5a2f715b1c65809ae81f1d56deb2fccb653c.camel@sipsolutions.net>
Subject: Re: [RFC v7 15/21] um: nommu: integrate with irq infrastructure of
 UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Wed, 07 Oct 2020 21:09:29 +0200
In-Reply-To: <68b53edd5ec17510626ae19546752cde198ecc3e.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <68b53edd5ec17510626ae19546752cde198ecc3e.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> @@ -541,6 +542,11 @@ unsigned long to_irq_stack(unsigned long *mask_out)
>  	unsigned long mask, old;
>  	int nested;
>  
> +#ifndef CONFIG_MMU

Also here and throughout, not sure I like (and it makes sense) to have
the equation of !CONFIG_MMU == LKL.

I mean, sure, that may actually be _true_ (at least right now), but it
doesn't feel like all of this really is a consequence of *NOMMU*, it's
more a consequence of LKL.

At least I think it is?

johannes


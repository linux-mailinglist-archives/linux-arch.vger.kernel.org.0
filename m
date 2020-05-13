Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386191D1193
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 13:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbgEMLjy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 07:39:54 -0400
Received: from foss.arm.com ([217.140.110.172]:44010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgEMLjx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 07:39:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F048D6E;
        Wed, 13 May 2020 04:39:53 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BFBA3F71E;
        Wed, 13 May 2020 04:39:52 -0700 (PDT)
Date:   Wed, 13 May 2020 12:39:50 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/14] prctl.2: ffix quotation mark tweaks
Message-ID: <20200513113949.GI21779@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-7-git-send-email-Dave.Martin@arm.com>
 <7afe32a5-9675-74d4-7c39-f1271d475afd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7afe32a5-9675-74d4-7c39-f1271d475afd@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 13, 2020 at 12:11:21PM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Dave,
> 
> On 5/12/20 6:36 PM, Dave Martin wrote:
> > Convert quote marks used for information terms in prose to use
> > \(oq .. \(cq, for better graphical rendering.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> Again, this is a patch that I would prefer to see near the end 
> of a series, rather than in the middle.
> 
> I'm currently agnostic about this change. But, I do not
> want to apply this patch, since no other pages in man-pages
> use \(oq...\(cq.
> 
> I haven't applied this patch. Luckily, that does not prevent
> any of the later patches applying.

I'll be careful to move this sort of thing to the end of a series in
future.

This was a provocative patch, so I'm happy for it to be dropped.


The main motivation was that ' renders to PostScript etc. as a closing
quote, which is fine for apostrophes but not fine for an opening quote
mark.  Most of the current quotes in here are actually ", but I don't
see an actual promise from groff that that renders as a neutral glyph
either, so it seemed best to avoid.  For now " does seem to be rendered
with a neutral glyph (i.e., neither opening or closing).

> > ---
> > 
> > Note, this can lead to misrendering on badly-configured systems.
> > However, many man pages do it.
> 
> Can you say some more about this please?

Terminal character maps need to match LANG etc. in order for fancy
characters coming out of nroff to display correctly.

ssh attempts to send LANG across, but terminal sessions between systems
that have different locales installed can be a problem, as can dumb
serial links that don't magically pass the locale and terminal type
settings across.

The fact that I hit this problem a lot in some situations (particularly
the serial link case) suggested to me that fancy characters are
considered fine nowadays, but perhaps I'd need to dig into it some more
to understand the situation fully.

(There are one or two ' that should really be \(aq anyway, but I'll
try to address that separately.)

Cheers
---Dave

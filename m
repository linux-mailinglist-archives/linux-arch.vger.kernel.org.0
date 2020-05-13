Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE621D1054
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 12:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgEMK4X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 06:56:23 -0400
Received: from foss.arm.com ([217.140.110.172]:43306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgEMK4X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 06:56:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1906030E;
        Wed, 13 May 2020 03:56:23 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6418A3F71E;
        Wed, 13 May 2020 03:56:22 -0700 (PDT)
Date:   Wed, 13 May 2020 11:56:20 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/14] prctl.2: srcfix add comments for navigation
Message-ID: <20200513105620.GE21779@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-5-git-send-email-Dave.Martin@arm.com>
 <8b882b6e-376b-111d-3c3c-7a042b0e91b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b882b6e-376b-111d-3c3c-7a042b0e91b5@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 13, 2020 at 12:09:27PM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Dave,
> 
> On 5/12/20 6:36 PM, Dave Martin wrote:
> > The prctl.2 source is unnecessarily hard to navigate, not least
> > because prctl option flags are traditionally named PR_* and so look
> > just like prctl names.
> > 
> > For each actual prctl, add a comment of the form
> > 
> > 	.\" prctl PR_FOO
> > 
> > to make it move obvious where each top-level prctl starts.
> > 
> > Of course, we could add some clever macros, but let's not confuse
> > dumb parsers.
> 
> A patch like this, which makes sweeping changes across the page,
> should be best placed at the end of a series, I think.
> The reason is that if I fail to apply this patch (and I am a
> little dubious about it), then probably the rest of the patches
> in the series won't apply. (Furthermore, it also forced me to
> apply patch 02 already, which I wanted to reflect on a little.)

Agreed, I'll try to do that in future.

> That said, I'll apply it, so that the remaining patches
> apply cleanly. I'll consider later whether to keep this
> change. For example, I wonder if a visually distinctive 
> source line that is always the same would be better than
> these comments that repeat the PR_* names. For example, 
> something like
> 
> .\" ==========================
> 
> I'll circle back to this later.

I'd prefer to keep the name if we can, since navigating by search is
otherwise bothersome due to false hits.

Could we do both, say:

.\" === PR_FOO ===

If you prefer to reject this patch, I'm happy to rebase and repost the
series as appropriate.

In any case, this one is nice to have rather than essential.

Cheers
---Dave

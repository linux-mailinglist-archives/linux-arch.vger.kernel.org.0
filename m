Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC091D10D0
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 13:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbgEMLNp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 07:13:45 -0400
Received: from foss.arm.com ([217.140.110.172]:43554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730908AbgEMLNo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 07:13:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8085C30E;
        Wed, 13 May 2020 04:13:43 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D09BF3F71E;
        Wed, 13 May 2020 04:13:42 -0700 (PDT)
Date:   Wed, 13 May 2020 12:13:40 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/14] prctl.2: Add health warning
Message-ID: <20200513111340.GF21779@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-3-git-send-email-Dave.Martin@arm.com>
 <93c5bfe6-fbbe-93ca-ef9c-91228c99d31b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93c5bfe6-fbbe-93ca-ef9c-91228c99d31b@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 13, 2020 at 12:10:25PM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Dave,
> 
> On 5/12/20 6:36 PM, Dave Martin wrote:
> > In reality, almost every prctl interferes with assumptions that the
> > compiler and C library / runtime rely on.  prctl() can therefore
> > make userspace explode in a variety ways that are likely to be hard
> > to debug.
> > 
> > This is not obvious to the uninitiated, so add a warning.
> 
> Patch applied. But see my comments on patch 04. I may want to 
> circle back on this patch later, since the wording feels a 
> little strong to me (we simply must use prctl for some things, 
> and not all of those things break user-space/runtime as far 
> as I know). If you have some thoughts on softening the warning,
> let me know.

Certainly the "if at all" can go -- this was just a suggestion
really.

Maybe the whole thing is superfluous.  In C anything can screw up the
runtime if you try hard enough.


The background to this patch is that things like the new
PR_PAC_RESET_KEYS and PR_SVE_SET_VL are likely to crash the program, or
place a timebomb that will explode later when someone upgrades their
toolchain or links with a new version of some library.  Many existing
prctls that look equally unfriendly...

I didn't want to say nothing at all, but I didn't want to get into the
gory details either.

Doing the digging to document the safety requirements of each prctl
would be a lot of work, and probably an exercise in futility anyway --
how to use a lot of prctls safely depends on the run-time environment as
much as it does on the kernel.


If you want to drop this, I'm happy to add explicit notes to just the
new arm64 prctls instead for now.

Cheers
---Dave

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BBD1D167B
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 15:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbgEMNx2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 09:53:28 -0400
Received: from foss.arm.com ([217.140.110.172]:47144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgEMNx1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 09:53:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 029931FB;
        Wed, 13 May 2020 06:53:27 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CF543F71E;
        Wed, 13 May 2020 06:53:26 -0700 (PDT)
Date:   Wed, 13 May 2020 14:53:24 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 10/14] prctl.2: Add PR_SPEC_INDIRECT_BRANCH for
 SPECULATION_CTRL prctls
Message-ID: <20200513135323.GO21779@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-11-git-send-email-Dave.Martin@arm.com>
 <bd548916-11c8-a53f-67b5-876c79088258@gmail.com>
 <20200513114915.GL21779@arm.com>
 <604879eb-1c7e-d08b-a6b8-165e4259b60c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <604879eb-1c7e-d08b-a6b8-165e4259b60c@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 13, 2020 at 02:06:38PM +0200, Michael Kerrisk (man-pages) wrote:
> On 5/13/20 1:49 PM, Dave Martin wrote:
> > On Wed, May 13, 2020 at 01:21:12PM +0200, Michael Kerrisk (man-pages) wrote:
> >> Hello Dave,
> >>
> >> On 5/12/20 6:36 PM, Dave Martin wrote:
> >>> Add the PR_SPEC_INDIRECT_BRANCH "misfeature" added in Linux 4.20
> >>> for PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
> >>>
> >>> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> >>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> >>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>
> >> Thanks. Patch applied, but not yet pushed while I wait to see if any
> >> Review/Ack arrives.
> >>
> >> Also, could you please check the tweaks I note below.
> >>
> >>> ---
> >>>  man2/prctl.2 | 24 ++++++++++++++++++------
> >>>  1 file changed, 18 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/man2/prctl.2 b/man2/prctl.2
> >>> index e8eaf95..66417cf 100644
> >>> --- a/man2/prctl.2
> >>> +++ b/man2/prctl.2
> >>> @@ -1213,11 +1213,20 @@ arguments must be specified as 0; otherwise the call fails with the error
> >>>  .\" commit 356e4bfff2c5489e016fdb925adbf12a1e3950ee
> >>>  Sets the state of the speculation misfeature specified in
> >>>  .IR arg2 .
> >>> -Currently, the only permitted value for this argument is
> >>> +Currently, this argument must be one of:
> >>> +.RS
> >>> +.TP
> >>>  .B PR_SPEC_STORE_BYPASS
> >>> -(otherwise the call fails with the error
> >>> +speculative store bypass control, or
> >>
> >> s/speculative/enable speculative/
> >>
> >>> +.\" commit 9137bb27e60e554dab694eafa4cca241fa3a694f
> >>> +.TP
> >>> +.BR PR_SPEC_INDIRECT_BRANCH " (since Linux 4.20)"
> >>> +indirect branch speculation control.
> >>
> >> s/indirect/enable indirect/
> > 
> > That doesn't seem quite right.
> 
> My goof, not looking at the bigger context of the patch.
> 
> > 
> > arg2 just identifies what behaviour to configure.
> > It's arg3 that says whether to disable / enable it or whatever.
> > 
> > 
> > While editing this I did wonder whether the "control" was helpful.
> > Maybe just dropping that word from these entries would help.
> 
> Okay I tried to fix things, and made also some other edits.
> How does the following look to you?
> 
>       PR_SET_SPECULATION_CTRL (since Linux 4.17)
>               Sets the state of the speculation misfeature  specified  in
>               arg2.   The  speculation-misfeature settings are per-thread
>               attributes.
> 
>               Currently, arg2 must be one of:
> 
>               PR_SPEC_STORE_BYPASS
>                      Set the state of the speculative store  bypass  mis‐
>                      feature.
> 
>               PR_SPEC_INDIRECT_BRANCH (since Linux 4.20)
>                      Set  the  state  of  the indirect branch speculation
>                      misfeature.
> 
>               If arg2 does not have one of the  above  values,  then  the
>               call fails with the error ENODEV.
> 
>               The  arg3  argument  is  used to hand in the control value,
>               which is one of the following:
> 
>               ...

Look OK to me.

I thought it sounded odd to "set the state" of a silicon bug, but that
was a bogus concern.

This isn't about bugs, but intentional, often configurable behaviours in
the silicon that happen to have harmful side effects.

It could be more terse to say "configure" instead of "set the state of",
but either way works for me.

Cheers
---Dave

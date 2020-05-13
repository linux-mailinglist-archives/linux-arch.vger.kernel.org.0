Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EF71D11B0
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgEMLpy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 07:45:54 -0400
Received: from foss.arm.com ([217.140.110.172]:44126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgEMLpy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 07:45:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B8F430E;
        Wed, 13 May 2020 04:45:51 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACB843F71E;
        Wed, 13 May 2020 04:45:50 -0700 (PDT)
Date:   Wed, 13 May 2020 12:45:48 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/14] prctl.2: tfix listing order of prctls
Message-ID: <20200513114548.GK21779@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-6-git-send-email-Dave.Martin@arm.com>
 <1bb991f4-176a-a74e-01fc-c73b49ed77f5@gmail.com>
 <20200513112133.GH21779@arm.com>
 <6ef9a969-3e16-e21c-f047-e5a471cbc163@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ef9a969-3e16-e21c-f047-e5a471cbc163@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 13, 2020 at 01:31:32PM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Dave,
> 
> On 5/13/20 1:21 PM, Dave Martin wrote:
> > On Wed, May 13, 2020 at 12:10:53PM +0200, Michael Kerrisk (man-pages) wrote:
> >> Hi Dave,
> >>
> >> On 5/12/20 6:36 PM, Dave Martin wrote:
> >>> The prctl list has historically been sorted by prctl name (ignoring
> >>> any SET_ or GET_ prefix) to make individual prctls easier to find.
> >>> Some noise seems to have crept in since.
> >>>
> >>> Sort the list back into order.  Similarly, reorder the list of
> >>> prctls specified to return non-zero values on success.
> >>
> >> This is a good patch. But see my comments on patch 04.
> >> I'd prefer a patch like this at the end of a series, 
> >> rather than in the middle of it.
> > 
> > Ack.
> > 
> > Ideally we could check the order with a script, but that seemed a step
> > too far.
> 
> Quite.
> 
> > What's the view on having parts of the man pages generated, rather then
> > being distributed ready-built?
> 
> I'm not keen (until someone shows me compelling benefits). Splitting
> things up would make pages harder to edit, and IMO increase
> the chance for inconsistencies in pages.

Fair enough.  I might experiment with something, but I won't expect an
easy sell!

This sort of thing was part of my motivation for having a distinctive
marker for the start of each prctl entry.

> 
> > If we split prctl.2 up with a fragment per prctl, we could paste the
> > fragments together in the right order with a script.
> > 
> >>
> >>> Content movement only.  No semantic change.
> >>
> >> And explicitly noting that detail is very helpful to me.
> > 
> > Unless of course I'm lying ;)  (I'm not, but I won't be offended if you
> > check.)
> 
> Actually, with your first two patches, you impressed right out of
> the gate, so my "I'm gonna blindly trust this guy" needle already
> switched up pretty high :-).

I guess I'll need to be careful...

Cheers
---Dave

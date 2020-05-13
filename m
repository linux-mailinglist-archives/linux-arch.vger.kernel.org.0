Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301271D112F
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 13:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgEMLVh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 07:21:37 -0400
Received: from foss.arm.com ([217.140.110.172]:43748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730571AbgEMLVg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 07:21:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43D9030E;
        Wed, 13 May 2020 04:21:36 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F6D33F71E;
        Wed, 13 May 2020 04:21:35 -0700 (PDT)
Date:   Wed, 13 May 2020 12:21:33 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/14] prctl.2: tfix listing order of prctls
Message-ID: <20200513112133.GH21779@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-6-git-send-email-Dave.Martin@arm.com>
 <1bb991f4-176a-a74e-01fc-c73b49ed77f5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bb991f4-176a-a74e-01fc-c73b49ed77f5@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 13, 2020 at 12:10:53PM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Dave,
> 
> On 5/12/20 6:36 PM, Dave Martin wrote:
> > The prctl list has historically been sorted by prctl name (ignoring
> > any SET_ or GET_ prefix) to make individual prctls easier to find.
> > Some noise seems to have crept in since.
> > 
> > Sort the list back into order.  Similarly, reorder the list of
> > prctls specified to return non-zero values on success.
> 
> This is a good patch. But see my comments on patch 04.
> I'd prefer a patch like this at the end of a series, 
> rather than in the middle of it.

Ack.

Ideally we could check the order with a script, but that seemed a step
too far.

What's the view on having parts of the man pages generated, rather then
being distributed ready-built?

If we split prctl.2 up with a fragment per prctl, we could paste the
fragments together in the right order with a script.

> 
> > Content movement only.  No semantic change.
> 
> And explicitly noting that detail is very helpful to me.

Unless of course I'm lying ;)  (I'm not, but I won't be offended if you
check.)

Cheers
---Dave

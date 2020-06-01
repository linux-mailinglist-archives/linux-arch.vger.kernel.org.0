Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D91EA54F
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jun 2020 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgFANvR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jun 2020 09:51:17 -0400
Received: from foss.arm.com ([217.140.110.172]:38446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgFANvR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jun 2020 09:51:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75B0755D;
        Mon,  1 Jun 2020 06:51:16 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7602E3F52E;
        Mon,  1 Jun 2020 06:51:15 -0700 (PDT)
Date:   Mon, 1 Jun 2020 14:51:13 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/6] prctl.2: Add PR_SPEC_INDIRECT_BRANCH for
 SPECULATION_CTRL prctls
Message-ID: <20200601135112.GB5031@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-3-git-send-email-Dave.Martin@arm.com>
 <CAKgNAkhwYASEM+wqaDZQ-ftcB3jnsVN2cXq4E_1ep1rqv+4aLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkhwYASEM+wqaDZQ-ftcB3jnsVN2cXq4E_1ep1rqv+4aLw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 28, 2020 at 09:01:59AM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Dave,
> 
> On Wed, 27 May 2020 at 23:18, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > Add the PR_SPEC_INDIRECT_BRANCH "misfeature" added in Linux 4.20
> > for PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> 
> I had also applied this patch from the email you sent earlier. I've
> pushed those changes to master now.

Thanks for this.

Do you publish a "development" branch somewhere, or similar?

If possible, it's nice to have git rebase work out which patches to drop
for me rather than me doing it by hand.

Don't bother if publishing an extra branch doesn't fit with your
workflow, though.

Cheers
---Dave

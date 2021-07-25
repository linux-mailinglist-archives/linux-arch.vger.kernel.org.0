Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDFF3D4D11
	for <lists+linux-arch@lfdr.de>; Sun, 25 Jul 2021 12:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhGYJca (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Jul 2021 05:32:30 -0400
Received: from cynthia.allandria.com ([50.242.82.17]:42350 "EHLO
        cynthia.allandria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhGYJc3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jul 2021 05:32:29 -0400
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1m7b7t-0001kc-HR; Sun, 25 Jul 2021 03:12:53 -0700
Date:   Sun, 25 Jul 2021 03:12:53 -0700
From:   Brad Boyer <flar@allandria.com>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
Message-ID: <20210725101253.GA6096@allandria.com>
References: <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
 <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com>
 <87h7gopvz2.fsf@disp2133>
 <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com>
 <877dhio13t.fsf@disp2133>
 <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com>
 <87tukkk6h3.fsf@disp2133>
 <df6618bf-d1bc-4759-2d14-934c22d54a83@gmail.com>
 <87eebn7w7y.fsf@igel.home>
 <db43bef1-7938-4fc1-853d-c20d66521329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db43bef1-7938-4fc1-853d-c20d66521329@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 25, 2021 at 07:44:11PM +1200, Michael Schmitz wrote:
> Am 25.07.2021 um 00:05 schrieb Andreas Schwab:
> >On Jul 24 2021, Michael Schmitz wrote:
> >
> >>According to my understanding, you can't get a F-line exception on
> >>68040.
> >
> >The F-line exception vector is used for all FPU illegal and
> >unimplemented insns.
> 
> Thanks - now from my reading of the fpsp040 code (which has mislead me in
> the past), it would seem that operations like sin() and exp() ought to raise
> that exception then. I don't see that in ARAnyM.

Yes, according to the 68040 user's manual, unimplemented and illegal F-line
instructions trigger the standard F-line exception vector (11) but have
separate stack frame formats so the fpsp040 code gets some extra data.
The CPU does a bunch of the prep work so that part doesn't need to be
emulated in software.

The ARAnyM docs appear to claim a strange combination that wouldn't
exist in hardware by implementing a full 68882 instead of the limited
subset found on a real 68040. Strangely, that might have been easier to
implement. However, it would also completely bypass any use of fpsp040.

	Brad Boyer
	flar@allandria.com


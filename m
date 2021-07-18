Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177A23CCB00
	for <lists+linux-arch@lfdr.de>; Sun, 18 Jul 2021 23:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhGRVnB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Jul 2021 17:43:01 -0400
Received: from cynthia.allandria.com ([50.242.82.17]:39306 "EHLO
        cynthia.allandria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhGRVnB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Jul 2021 17:43:01 -0400
X-Greylist: delayed 2400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Jul 2021 17:43:01 EDT
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1m5DtE-0000MP-HI; Sun, 18 Jul 2021 13:59:56 -0700
Date:   Sun, 18 Jul 2021 13:59:56 -0700
From:   Brad Boyer <flar@allandria.com>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
Message-ID: <20210718205956.GA802@allandria.com>
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
 <87zgunzovm.fsf@disp2133>
 <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
 <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com>
 <8735scvklk.fsf@disp2133>
 <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
 <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com>
 <87a6mj99vf.fsf@igel.home>
 <1ebfb9de-de16-d05c-ea15-a110857fe284@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ebfb9de-de16-d05c-ea15-a110857fe284@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 19, 2021 at 07:47:19AM +1200, Michael Schmitz wrote:
> Somewhere in entry.S is
> 
> addql   #8,%sp
> addql   #4,%sp
> 
> - is that faster than
> 
> lea     12(%sp),%sp ?

On the 68040 the timing can depend on the other instructions around
it. Each of those addql instructions is listed as 1 and 1 for
fetch/execute, while that lea is listed as 2 and 1L+1 meaning that
it could potentially be faster depending on the behavior of the
instruction that preceded it thorough the execute stage. That one
free cycle if the stage is busy (due to the 1L) could make it
effectively faster since the first addql would have to wait that
extra cycle in that case.

On the 68060, it looks like the lea version is the clear winner,
although the timing description is obviously much more complicated
and thus I might have missed something. From a quick look, it
seems that lea takes the same time as just the first addql.

On CPU32, the lea version loses due to the extra 3 cycles from
the addressing mode, even though the base cycles of lea are the
same as for addql (2 cycles each). The lea might be even worse
if it can't take advantage of overlapping the surrounding
instructions (1 cycle before and 1 after).

Those are the only ones I already have the documentation in my
hands. I haven't checked older classic cores or coldfire, but
it does seem like it is specific to each chip which is faster.

Obviously both versions would be the same size (2 words).

	Brad Boyer
	flar@allandria.com


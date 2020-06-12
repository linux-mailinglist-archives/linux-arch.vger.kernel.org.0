Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1616C1F734D
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jun 2020 07:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFLFIb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Jun 2020 01:08:31 -0400
Received: from smtp-1.orcon.net.nz ([60.234.4.34]:34317 "EHLO
        smtp-1.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgFLFIb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jun 2020 01:08:31 -0400
X-Greylist: delayed 1223 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2020 01:08:30 EDT
Received: from [121.99.228.40] (port=19283 helo=tower)
        by smtp-1.orcon.net.nz with esmtpa (Exim 4.90_1)
        (envelope-from <mcree@orcon.net.nz>)
        id 1jjbbm-0007KJ-5z; Fri, 12 Jun 2020 16:48:02 +1200
Date:   Fri, 12 Jun 2020 16:47:57 +1200
From:   Michael Cree <mcree@orcon.net.nz>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: Regression bisected to f2f84b05e02b (bug: consolidate
 warn_slowpath_fmt() usage)
Message-ID: <20200612044757.GA10703@tower>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
        Matt Turner <mattst88@gmail.com>, Kees Cook <keescook@chromium.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>
References: <20200602024804.GA3776630@p50-ethernet.mattst88.com>
 <202006021052.E52618F@keescook>
 <CAEdQ38F2GP92xB2gMXTrEo-Adbbc9Cy1DWHU9yveGLzJNd2HrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEdQ38F2GP92xB2gMXTrEo-Adbbc9Cy1DWHU9yveGLzJNd2HrA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 11, 2020 at 09:23:52PM -0700, Matt Turner wrote:
> Since I noticed earlier that using maxcpus=1 on a 2-CPU system
> prevented the system from hanging, I tried disabling CONFIG_SMP on my
> 1-CPU system as well. In doing so, I discovered that the RCU torture
> module (RCU_TORTURE_TEST) triggers some null pointer dereferences on
> Alpha when CONFIG_SMP is set, but works successfully when CONFIG_SMP
> is unset.
> 
> That seems likely to be a symptom of the same underlying problem that
> started this thread, don't you think? If so, I'll focus my attention
> on that.

I wonder if that is related to user space segfaults we are now seeing
on SMP systems but not UP systems while building Alpha debian-ports.
It's happening in the test-suites of builds of certain software
(such as autogen and guile) but they always build successfully with
the test suite passing on a UP system.

When investigating I seem to recall it was a NULL (or near NULL)
pointer dereference but couldn't make any sense of how it might
have got into such an obviously wrong state.

Cheers,
Michael.

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DEA1C308B
	for <lists+linux-arch@lfdr.de>; Mon,  4 May 2020 02:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEDArS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 May 2020 20:47:18 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:53038 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726549AbgEDArR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 May 2020 20:47:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 84CBB1800A695;
        Mon,  4 May 2020 00:47:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2731:2828:3138:3139:3140:3141:3142:3350:3622:3865:3868:3870:3873:4321:5007:6119:6120:6742:6743:10004:10400:10848:10967:11232:11658:11914:12043:12297:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: pen33_21ed1a190575c
X-Filterd-Recvd-Size: 2603
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 May 2020 00:47:13 +0000 (UTC)
Message-ID: <a88be1298aa1600f46e868dd45f83a6075c7162e.camel@perches.com>
Subject: Re: [PATCH 12/14] docs: move remaining stuff under
 Documentation/*.txt to Documentation/staging
From:   Joe Perches <joe@perches.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Sameer Rahmani <lxsameer@gnu.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-remoteproc@vger.kernel.org, tee-dev@lists.linaro.org,
        linux-arch@vger.kernel.org
Date:   Sun, 03 May 2020 17:47:11 -0700
In-Reply-To: <20200504085415.db8e0e3b40e795f2fb4af009@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
         <28687056965ff46c0e6c81663a419bc59cfb94b4.1588345503.git.mchehab+huawei@kernel.org>
         <20200504085415.db8e0e3b40e795f2fb4af009@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2020-05-04 at 08:54 +0900, Masami Hiramatsu wrote:
> On Fri,  1 May 2020 17:37:56 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
[]
> > diff --git a/MAINTAINERS b/MAINTAINERS
[]
> > @@ -9855,7 +9855,7 @@ L:	linux-kernel@vger.kernel.org
> >  L:	linux-arch@vger.kernel.org
> >  S:	Supported
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> > -F:	Documentation/atomic_bitops.txt
> > +F:	Documentation/staging/atomic_bitops.txt

Can you please keep the file lists in alphabetic order
and move this entry down appropriately?  Thanks.

> >  F:	Documentation/atomic_t.txt
> >  F:	Documentation/core-api/atomic_ops.rst
> >  F:	Documentation/core-api/refcount-vs-atomic.rst



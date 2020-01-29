Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 298EE14CB20
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2020 14:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgA2NHj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jan 2020 08:07:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40160 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgA2NHj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jan 2020 08:07:39 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00TCrF6V012228;
        Wed, 29 Jan 2020 13:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2019-08-05;
 bh=Ti8ZyKANi8j7nbulPgsnFv9qnobLhcvfN7U/r0qXW7E=;
 b=LBahaheaQvC3glSE4e8w07NZ4e3ZMriTaXdGJFAtdGuB2GraI+YteA2MAbZxwfBTY40l
 HuZOessuTUnU1X5x8qqSgOHwbIT3he0G7GFxjbucwmqWYzAg9vrCZOtPyYtgwsZaELFN
 38ehsE4YZg7gSOr3FVgmNTR78IouMyz495eIB+OVXsAXUX4nhPY3Si8mx674EUqUspNb
 oTfEjDX3f6tkSraJ5DpYPTZ6L2R/BZPFU1ipG/iplPG/0uvRjWxioS0A3mPFCuB/5W//
 4D0PM+bSYqdUSdkw5oRq90y+YnxoCvbLbLHTlrpR8hNTmumssS+LR4PhOD3m4SjzFvFO Fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xrdmqn5ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 13:06:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00TD2TvJ000907;
        Wed, 29 Jan 2020 13:06:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2xtmr94ng4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 13:06:53 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00TD6lGS005320;
        Wed, 29 Jan 2020 13:06:47 GMT
Received: from dhcp-10-175-173-43.vpn.oracle.com (/10.175.173.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jan 2020 05:06:46 -0800
Date:   Wed, 29 Jan 2020 13:06:34 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-173-43.vpn.oracle.com
To:     Frank Rowand <frowand.list@gmail.com>
cc:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v1 0/6] kunit: create a centralized executor to dispatch
 all KUnit tests
In-Reply-To: <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com>
Message-ID: <alpine.LRH.2.20.2001291006570.13921@dhcp-10-175-173-43.vpn.oracle.com>
References: <20191216220555.245089-1-brendanhiggins@google.com> <20200106224022.GX11244@42.do-not-panic.com> <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com> <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com>
 <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com> <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001290108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001290107
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 28 Jan 2020, Frank Rowand wrote:

> On 1/28/20 1:19 AM, Brendan Higgins wrote:
> > On Mon, Jan 27, 2020 at 9:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 1/23/20 4:40 PM, Brendan Higgins wrote:
> >>> Sorry for the late reply. I am still catching up from being on vacation.
> >>>>> On Mon, Jan 6, 2020 at 2:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>>> It does beg the question if this means kunit is happy to not be a tool
> >>>> to test pre basic setup stuff (terminology used in init.c, meaning prior
> >>>> to running all init levels). I suspect this is the case.
> >>>
> >>> Not sure. I still haven't seen any cases where this is necessary, so I
> >>> am not super worried about it. Regardless, I don't think this patchset
> >>> really changes anything in that regard, we are moving from late_init
> >>> to after late_init, so it isn't that big of a change for most use
> >>> cases.
> >>>
> >>> Please share if you can think of some things that need to be tested in
> >>> early init.
> >>
> >> I don't have a specific need for this right now.  I had not thought about
> >> how the current kunit implementation forces all kunit tests to run at a
> >> specific initcall level before reading this email thread.
> >>
> >> I can see the value of being able to have some tests run at different
> >> initcall levels to verify what functionality is available and working
> >> at different points in the boot sequence.
> > 
> > Let's cross that bridge when we get there. It should be fairly easy to
> > add that functionality.
> 
> Yes. I just wanted to add the thought to the back of your mind so that
> it does not get precluded by future changes to the kunit architecture.
> 
> > 
> >> But more important than early initcall levels, I do not want the
> >> framework to prevent using or testing code and data that are marked
> >> as '__init'.  So it is important to retain a way to invoke the tests
> >> while __init code and data are available, if there is also a change
> >> to generally invoke the tests later.
> > 
> > Definitely. For now that still works as long as you don't build KUnit
> > as a module, but I think Alan's new patches which allow KUnit to be
> > run at runtime via debugfs could cause some difficulty there. Again,
> 
> Yes, Alan's patches are part of what triggered me thinking about the
> issues I raised.
> 
>

As Brendan says, any such tests probably shouldn't be buildable
as modules, but I wonder if we need to add some sort of way
to ensure execution from debugfs is not allowed for such cases?
Even if a test suite is builtin, it can be executed via debugfs
in the patches I sent out, allowing suites to be re-run.  Sounds
like we need a way to control that behaviour based on the
desired test suite execution environment.

Say, for example, the "struct kunit_suite" definitions associated
with the tests was marked as __initdata; are there any handy macros to 
identify it as being in the __init section? If so, we could simply
avoid adding a "run" file to the debugfs representation for such
suites.  Failing that, perhaps we need some sort of flags field
in "struct kunit_suite" to specify execution environment constraints?

Thanks!

Alan

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A985B33A7F
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2019 23:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfFCV7H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jun 2019 17:59:07 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:50772 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbfFCV7H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2019 17:59:07 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 40F2EC1E8F;
        Mon,  3 Jun 2019 21:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559599156; bh=dNg1Wi9QIPPZ6xZvn5MUOdQ8oFIGLsTJA4xuoGPffxI=;
        h=From:To:CC:Subject:Date:References:From;
        b=ARfkJIZCZiHrFoce3E8ebmpCSa/ze39hP83+SvbN8LJJvnL2KM49CuAYk6UNvKYxH
         jgER1JODLivb4nH3MTq6PNLyYFAsnekqfivnUWgeWeUoAgOf1Os67kuiFkgnJwc5Ic
         PWhNwQmDrEBiq/KlU2GsgLljx9ygbrOOKN5KScI6xE0XYRY3ANQ6tunci2lk6oY4nr
         zahdqemc3iHPTvTQ+EBkKuvUJyX8UDQSdoQVJU4TOv0tJLK6Ou566rTrnlutKrHzvZ
         IESCJveC6prys6IB8/2Dky3s280asMUnFU5Y9mjHKMHJYG8M9uyTwG4l3p85ERAr0j
         L903tG4H277qA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9F076A005D;
        Mon,  3 Jun 2019 21:59:05 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.22]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Mon, 3 Jun 2019 14:59:04 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <Will.Deacon@arm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Thread-Topic: single copy atomicity for double load/stores on 32-bit systems
Thread-Index: AQHVGkjSbYnGBSHcp0iQsqIdFKOjIw==
Date:   Mon, 3 Jun 2019 21:59:03 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2523460@us01wembx1.internal.synopsys.com>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A2522B5B@us01wembx1.internal.synopsys.com>
 <20190603201324.GN28207@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/3/19 1:13 PM, Paul E. McKenney wrote:=0A=
> On Mon, Jun 03, 2019 at 06:08:35PM +0000, Vineet Gupta wrote:=0A=
>> On 5/31/19 1:21 AM, Peter Zijlstra wrote:=0A=
>>>> I'm not sure how to interpret "natural alignment" for the case of doub=
le=0A=
>>>> load/stores on 32-bit systems where the hardware and ABI allow for 4 b=
yte=0A=
>>>> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)=0A=
>>> Natural alignment: !((uintptr_t)ptr % sizeof(*ptr))=0A=
>>>=0A=
>>> For any u64 type, that would give 8 byte alignment. the problem=0A=
>>> otherwise being that your data spans two lines/pages etc..=0A=
>> Sure, but as Paul said, if the software doesn't expect them to be atomic=
 by=0A=
>> default, they could span 2 hardware lines to keep the implementation sim=
pler/sane.=0A=
> I could imagine 8-byte types being only four-byte aligned on 32-bit syste=
ms,=0A=
> but it would be quite a surprise on 64-bit systems.=0A=
=0A=
Totally agree !=0A=
=0A=
Thx,=0A=
-Vineet=0A=

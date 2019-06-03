Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA5133787
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jun 2019 20:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfFCSIk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jun 2019 14:08:40 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:51980 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbfFCSIk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2019 14:08:40 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 333CBC2132;
        Mon,  3 Jun 2019 18:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559585300; bh=0UhEzVtwwbxv/sHK4Tn8wIkMCFphv3Lw9ONZypJrIYc=;
        h=From:To:CC:Subject:Date:References:From;
        b=b+AgoA0yEgOTv+uklEZZS6H+wCJmYnLr3Y83YXD3PmzDXVtrox3X9xFTQHc/Kdgjl
         BgQa3XED+MyOcgJR/y9PN/YF3Y3sNmaBdeyqMK0fYsx4LkZq9pgiXOSEdibSlgTK+a
         N1eFRakZzSSicJSod5B1C709+/RqxRW7wlSm29kecjhiuN3J0q2viVnYxdTK8UnFcu
         Ymowiv6VMhK0Dw4Fa/iGGDx3Ct6Q3RLI4nM9ppRTvpHk6EMuvG4vWD8Rxg1VkYhiEQ
         j/hMwbQg+BjDMSnHEJIfvsSz74kobeaCuWf0XMes8zghuM1sijwqJDe7texviU4L2M
         4MIZ9hiY38YDQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id ABAF9A006A;
        Mon,  3 Jun 2019 18:08:35 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.22]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 3 Jun 2019 11:08:35 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Will Deacon <Will.Deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Thread-Topic: single copy atomicity for double load/stores on 32-bit systems
Thread-Index: AQHVFxS3L0CUD1w2LkO7mj7CwLHhlw==
Date:   Mon, 3 Jun 2019 18:08:35 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2522B5B@us01wembx1.internal.synopsys.com>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net>
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

On 5/31/19 1:21 AM, Peter Zijlstra wrote:=0A=
>> I'm not sure how to interpret "natural alignment" for the case of double=
=0A=
>> load/stores on 32-bit systems where the hardware and ABI allow for 4 byt=
e=0A=
>> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)=0A=
> Natural alignment: !((uintptr_t)ptr % sizeof(*ptr))=0A=
>=0A=
> For any u64 type, that would give 8 byte alignment. the problem=0A=
> otherwise being that your data spans two lines/pages etc..=0A=
=0A=
Sure, but as Paul said, if the software doesn't expect them to be atomic by=
=0A=
default, they could span 2 hardware lines to keep the implementation simple=
r/sane.=0A=

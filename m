Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FE4301D8
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfE3SWz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 14:22:55 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:50084 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbfE3SWz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 14:22:55 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 97543C00B0;
        Thu, 30 May 2019 18:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559240584; bh=tXKhvVlPB83lnrd1soG4Udon/Z/gh72d6RoQk4zGMQY=;
        h=From:Subject:To:CC:Date:From;
        b=AWJDMB/lKPYORIWltA0gVIDA/bblb/OfrBvX4EsMpJtq5ysYbRaFFJNcKic+AmHEt
         bFW6N58qK4VY5vpdBkf6rI3gew7gnjCfI9XQQsNoF3ZGHcX/Dsm7ZlXUQI6U7WBS4S
         fVcTZcUQ0QX1ut8uC73HLqCcw+MZBH2C5W1RFaQgt836+zxTOmBNL5fF/mhlD5EP8N
         x0yChiH+/zJ5prVF3ahLy3REMlahcxJZDAeFcN5vRAG0HhblkGDrTbGWyArSHw0RGU
         lD6jt4lQhljX1J5jPd0J3PjVZMMXufV2+uY/2HFUTRkPjGPWpVuOWg0T3tEHWy6CtH
         LGJjQckwzDhsg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 19922A0095;
        Thu, 30 May 2019 18:22:51 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 30 May 2019 11:22:51 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 30 May 2019 23:52:50 +0530
Received: from [10.10.161.35] (10.10.161.35) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 30 May 2019 23:53:02 +0530
X-Mozilla-News-Host: news://gmane.comp.lib.uclibc.buildroot:119
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 mQINBFEffBMBEADIXSn0fEQcM8GPYFZyvBrY8456hGplRnLLFimPi/BBGFA24IR+B/Vh/EFk
 B5LAyKuPEEbR3WSVB1x7TovwEErPWKmhHFbyugdCKDv7qWVj7pOB+vqycTG3i16eixB69row
 lDkZ2RQyy1i/wOtHt8Kr69V9aMOIVIlBNjx5vNOjxfOLux3C0SRl1veA8sdkoSACY3McOqJ8
 zR8q1mZDRHCfz+aNxgmVIVFN2JY29zBNOeCzNL1b6ndjU73whH/1hd9YMx2Sp149T8MBpkuQ
 cFYUPYm8Mn0dQ5PHAide+D3iKCHMupX0ux1Y6g7Ym9jhVtxq3OdUI5I5vsED7NgV9c8++baM
 7j7ext5v0l8UeulHfj4LglTaJIvwbUrCGgtyS9haKlUHbmey/af1j0sTrGxZs1ky1cTX7yeF
 nSYs12GRiVZkh/Pf3nRLkjV+kH++ZtR1GZLqwamiYZhAHjo1Vzyl50JT9EuX07/XTyq/Bx6E
 dcJWr79ZphJ+mR2HrMdvZo3VSpXEgjROpYlD4GKUApFxW6RrZkvMzuR2bqi48FThXKhFXJBd
 JiTfiO8tpXaHg/yh/V9vNQqdu7KmZIuZ0EdeZHoXe+8lxoNyQPcPSj7LcmE6gONJR8ZqAzyk
 F5voeRIy005ZmJJ3VOH3Gw6Gz49LVy7Kz72yo1IPHZJNpSV5xwARAQABtCpWaW5lZXQgR3Vw
 dGEgKGFsaWFzKSA8dmd1cHRhQHN5bm9wc3lzLmNvbT6JAj4EEwECACgCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheABQJbBYpwBQkLx0HcAAoJEGnX8d3iisJeChAQAMR2UVbJyydOv3aV
 jmqP47gVFq4Qml1weP5z6czl1I8n37bIhdW0/lV2Zll+yU1YGpMgdDTHiDqnGWi4pJeu4+c5
 xsI/VqkH6WWXpfruhDsbJ3IJQ46//jb79ogjm6VVeGlOOYxx/G/RUUXZ12+CMPQo7Bv+Jb+t
 NJnYXYMND2Dlr2TiRahFeeQo8uFbeEdJGDsSIbkOV0jzrYUAPeBwdN8N0eOB19KUgPqPAC4W
 HCg2LJ/o6/BImN7bhEFDFu7gTT0nqFVZNXlOw4UcGGpM3dq/qu8ZgRE0turY9SsjKsJYKvg4
 djAaOh7H9NJK72JOjUhXY/sMBwW5vnNwFyXCB5t4ZcNxStoxrMtyf35synJVinFy6wCzH3eJ
 XYNfFsv4gjF3l9VYmGEJeI8JG/ljYQVjsQxcrU1lf8lfARuNkleUL8Y3rtxn6eZVtAlJE8q2
 hBgu/RUj79BKnWEPFmxfKsaj8of+5wubTkP0I5tXh0akKZlVwQ3lbDdHxznejcVCwyjXBSny
 d0+qKIXX1eMh0/5sDYM06/B34rQyq9HZVVPRHdvsfwCU0s3G+5Fai02mK68okr8TECOzqZtG
 cuQmkAeegdY70Bpzfbwxo45WWQq8dSRURA7KDeY5LutMphQPIP2syqgIaiEatHgwetyVCOt6
 tf3ClCidHNaGky9KcNSQ
Subject: single copy atomicity for double load/stores on 32-bit systems
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
Date:   Thu, 30 May 2019 11:22:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.35]
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

Had an interesting lunch time discussion with our hardware architects pertinent to
"minimal guarantees expected of a CPU" section of memory-barriers.txt


|  (*) These guarantees apply only to properly aligned and sized scalar
|     variables.  "Properly sized" currently means variables that are
|     the same size as "char", "short", "int" and "long".  "Properly
|     aligned" means the natural alignment, thus no constraints for
|     "char", two-byte alignment for "short", four-byte alignment for
|     "int", and either four-byte or eight-byte alignment for "long",
|     on 32-bit and 64-bit systems, respectively.


I'm not sure how to interpret "natural alignment" for the case of double
load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)

I presume (and the question) that lkmm doesn't expect such 8 byte load/stores to
be atomic unless 8-byte aligned

ARMv7 arch ref manual seems to confirm this. Quoting

| LDM, LDC, LDC2, LDRD, STM, STC, STC2, STRD, PUSH, POP, RFE, SRS, VLDM, VLDR,
| VSTM, and VSTR instructions are executed as a sequence of word-aligned word
| accesses. Each 32-bit word access is guaranteed to be single-copy atomic. A
| subsequence of two or more word accesses from the sequence might not exhibit
| single-copy atomicity

While it seems reasonable form hardware pov to not implement such atomicity by
default it seems there's an additional burden on application writers. They could
be happily using a lockless algorithm with just a shared flag between 2 threads
w/o need for any explicit synchronization. But upgrade to a new compiler which
aggressively "packs" struct rendering long long 32-bit aligned (vs. 64-bit before)
causing the code to suddenly stop working. Is the onus on them to declare such
memory as c11 atomic or some such.

Thx,
-Vineet

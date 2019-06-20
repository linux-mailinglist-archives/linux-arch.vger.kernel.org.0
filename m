Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07A44DB99
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2019 22:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfFTUt7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jun 2019 16:49:59 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:34506 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbfFTUt6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jun 2019 16:49:58 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8CF4CC0D2E;
        Thu, 20 Jun 2019 20:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561063798; bh=7Xu9jiEpOkMmqNXYHnZgozFosbClrmzrakUaaJSHzMk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=TgIpoUSGN8Z29denp348YrUQ7M4JCHy6erxt3AYYah8ed0I92f4wJM01DVHFEixFG
         jkgQqyp7TLJygOTs/cNpAXhQXuYg/aXfOb567orU1VEY6fBtSFXWP232SYyoe3vs/Z
         m3Ld/mWukZOkHvCYEj7s1hWCSTglnb0Ay6+ImFJTlUHqjAiNdqveEZWAFyE//MZHZq
         CDzpWIv6s45yYDzElNLuUuU6+O9Vi7KpvWaGs0f+ATMa8yaevMNcWRYNfRPEeas/+y
         bpuNY9TTcG9GVzpIimTl21Cgf0RH45MoY748qdUcfdDbJlNnXaWNyxtH9QTjxQ0MT/
         cVnY0L3whTHXw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 859ABA005D;
        Thu, 20 Jun 2019 20:49:56 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 20 Jun 2019 13:49:55 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 21 Jun 2019 02:19:53 +0530
Received: from [10.10.161.66] (10.10.161.66) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 21 Jun 2019 02:20:06 +0530
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Newsgroups: gmane.linux.kernel.arc,gmane.linux.kernel.cross-arch,gmane.linux.kernel
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
 <20190620075224.GT3419@hirez.programming.kicks-ass.net>
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
Message-ID: <9192bd26-5f34-dcbf-8552-2f474866a31e@synopsys.com>
Date:   Thu, 20 Jun 2019 13:49:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620075224.GT3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.66]
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/20/19 12:52 AM, Peter Zijlstra wrote:
> 
> With everything little endian, everything seems just fine. If you load
> the first 2 byte at offset 0, you get the first 2 bytes of the
> instruction.

It has to do with the instruction encoding scheme and what part of instruction has
the major opcode/subopcode etc. For a canonical 4 byte instruction they happen to
be in the upper 16 bits (for some hardware efficiency reasons unknown to me). So
when a 2 byte insn follows a 4 byte, a 4 byte fetch already tells it what the 2nd
instruction opcode is and whether it is a 2, 4, 6 or 8 byte insn.


> 
> If OTOH your arch big endian, and you were to load the first two bytes
> at offset 0, you get the top two.
> 
> So this middle endian scheme, only seems to make sense if you're
> otherwise big endian.

Insn encoding is always middl eendina - irrespective of endianness.

> But AFAICT ARC is bi-endian and the jump-label
> patch under condsideration is explicitly !CPU_ENDIAN_BE32 -- which
> suggests the instruction stream is sensitive to the endian selection.

Nope they are not directly related. Likely the difference is when we patch the
instruction to memory it is written as data so might need some endian swap. Not
really rocket science. Perhaps it saves some testing effort etc.
Also we don't seem to have any customers interested in BE these days.

> Anyway, I was just 'surprised' at seeing middle endian mentioned,
> curiosity killed the cat and all that :-)

Curiosity may certainly kill cats, but on lkml curiosity is almost always a good
thing both for the enquirer and enquiree ;-)




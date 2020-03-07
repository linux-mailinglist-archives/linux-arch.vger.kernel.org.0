Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC5717CA30
	for <lists+linux-arch@lfdr.de>; Sat,  7 Mar 2020 02:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgCGBK7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 20:10:59 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36864 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgCGBK6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 20:10:58 -0500
Received: by mail-qv1-f67.google.com with SMTP id w16so1430469qvn.4
        for <linux-arch@vger.kernel.org>; Fri, 06 Mar 2020 17:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EgkVlU+1chmZAdNkyF5q9aYrIAuysLZZez5WmPdEesQ=;
        b=EGv7Xx0mZhZufvegZpMUc+XHUkn93SE5ZYbqMRcl5l03s/x6c5RGn1Ma2qadFUAf7S
         mDQMjSqV0IMWb0LKZbXtHgPTizxmZGQTJdUUxxDOzRNaQofngetBXfwNZBmrbUir4STy
         e3xaR5vaUH0X/eG5wGlkW6iyRZ9+AVrlHBQUd8rTQK2YW8J6Zd2RLf0s/Z6jQ5Xya9vu
         aeJUNlgp7kS5lPRKKgCNzhDAIzhO4wqNELMKCmK5Pf7jkprIcuqhfAVWcp5Z+XuxcskU
         0FpMxIT78jjgIVAOm8sfqI2jqD5aX8zFE6cx/mP42YiyM5KNoK8iovEJATfquaQSZhHz
         6eAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EgkVlU+1chmZAdNkyF5q9aYrIAuysLZZez5WmPdEesQ=;
        b=P8V/4vY9LBHucukbUNMeY+SHZxeFBBJFA7kVuXG/tP/7KjifNtKw1IfFkRFTloeJiS
         5OSaw2qt4ND77jQQM7VmgT/d+cuVQuZe8AAhxznvvvhKaFcBgMpRkhwJ6nrPDpaiLwHq
         aUMJKWit0/MPDndGnRc7r8Yvpa/rG/cSdHx5vCO+zGCdGid4axR445fej/qWd2M2+nd2
         g3VMn29YjPjWc8dPGn5WqCmLlahLFx6J3tbZd/0HjB9D80TWEYR/rbmVuhSi2vSVDKwu
         XNSwd8lrm28ozeBay6JjfE+hHBML7Nstxf4c2lIZMxWOYGqzdKnV0/wN+kzdwyIanaGZ
         225g==
X-Gm-Message-State: ANhLgQ1sEUE2reBdG/HF9bNqCr7byCx/GZIeswYKE+jozZ4kAVd0QvLd
        5pYi7IaHzLD/HmFlNx8wHx15xw==
X-Google-Smtp-Source: ADFU+vsw52nux5Uc1WpPZ0fNtyFcwSVbVBgSYAhgVo8M+FINwP2UYIzF3QTk5i6KnfgTnuq5ecGdaA==
X-Received: by 2002:a0c:e401:: with SMTP id o1mr5556949qvl.19.1583543455511;
        Fri, 06 Mar 2020 17:10:55 -0800 (PST)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d35sm17605260qtc.21.2020.03.06.17.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 17:10:54 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH V15] mm/debug: Add tests validating architecture page
 table helpers
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <a45834bc-e6f2-ac21-de9e-1aff67d12797@arm.com>
Date:   Fri, 6 Mar 2020 20:10:52 -0500
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C65A91AB-3F70-4120-893D-2751601C0F25@lca.pw>
References: <61250cdc-f80b-2e50-5168-2ec67ec6f1e6@arm.com>
 <CEEAD95E-D468-4C58-A65B-7E8AED91168A@lca.pw>
 <a45834bc-e6f2-ac21-de9e-1aff67d12797@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Mar 6, 2020, at 7:56 PM, Anshuman Khandual =
<anshuman.khandual@arm.com> wrote:
>=20
>=20
>=20
> On 03/07/2020 06:04 AM, Qian Cai wrote:
>>=20
>>=20
>>> On Mar 6, 2020, at 7:03 PM, Anshuman Khandual =
<Anshuman.Khandual@arm.com> wrote:
>>>=20
>>> Hmm, set_pte_at() function is not preferred here for these tests. =
The idea
>>> is to avoid or atleast minimize TLB/cache flushes triggered from =
these sort
>>> of 'static' tests. set_pte_at() is platform provided and could/might =
trigger
>>> these flushes or some other platform specific synchronization stuff. =
Just
>>=20
>> Why is that important for this debugging option?
>=20
> Primarily reason is to avoid TLB/cache flush instructions on the =
system
> during these tests that only involve transforming different page table
> level entries through helpers. Unless really necessary, why should it
> emit any TLB/cache flush instructions ?
>=20
>>=20
>>> wondering is there specific reason with respect to the soft lock up =
problem
>>> making it necessary to use set_pte_at() rather than a simple =
WRITE_ONCE() ?
>>=20
>> Looks at the s390 version of set_pte_at(), it has this comment,
>> vmaddr);
>>=20
>> /*
>> * Certain architectures need to do special things when PTEs
>> * within a page table are directly modified.  Thus, the following
>> * hook is made available.
>> */
>>=20
>> I can only guess that powerpc  could be the same here.
>=20
> This comment is present in multiple platforms while defining =
set_pte_at().
> Is not 'barrier()' here alone good enough ? Else what exactly =
set_pte_at()

No, barrier() is not enough.

> does as compared to WRITE_ONCE() that avoids the soft lock up, just =
trying
> to understand.

I surely can spend hours to figure which exact things in set_pte_at() is =
necessary for
pte_clear() not to stuck, and then propose a solution and possible need =
to retest on
multiple arches. I am not sure if that is a good use of my time just to =
saving
a few TLB/cache flush on a debug kernel?=

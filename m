Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5962917C9C2
	for <lists+linux-arch@lfdr.de>; Sat,  7 Mar 2020 01:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCGAeX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 19:34:23 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36984 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCGAeX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 19:34:23 -0500
Received: by mail-qt1-f196.google.com with SMTP id l20so1464183qtp.4
        for <linux-arch@vger.kernel.org>; Fri, 06 Mar 2020 16:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Llth3MhUyFBOi7p0WfyKRqezwCMBh50m9NEH4AtRH1U=;
        b=puvFN+Oa4Vsque2ZZFahxBROstqlUCh6OUM3IAJz/PpFxOEwXVBDL1w614Lf5OgLn5
         ZzOKj9HWOalPOfhv3WAYO45FNOPCCJIbnU41PCb5bB2Jpfed/n8m6G0z5zQoTE4+Y2y9
         3QJpAM3ou6c7EdgrRsfCmCg49mhT4wc3UBudKo0M3IjKzr4rlUXBE2NlETbQYMK6HNXK
         FaW2q4McGhTj2NCjdx0Iunur4hGozNvUDxm9RmqprWgyakpEZ4US8GkH1ltbTWFsHiOw
         CwD/p2KKStXpzjgcBMWXRzzvBYt1qmOtcsAsjRrYeh1r/v9yIBxJhh+Vq48gTXYafbjW
         E5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Llth3MhUyFBOi7p0WfyKRqezwCMBh50m9NEH4AtRH1U=;
        b=g4j5A7WiVSV7dt/gIkuJ7spMf5UnktSX7ujNyw2+emxWfEhH7jjTW74vtoGVSITJIH
         Wz6jXYA2CRZPY2SWc1a6H8PGQCDP14LKcv/OwokJKA2OFlzolrz/hm/kRy5PmX316ki0
         mLWtzLwfCqDF+eKr+LUHmWqmiaiSVPZGmifchEkjIpN1+jUVIvgYtqCPkSKW1Nwon5tM
         i0SCdr5Ulc6UJ/VmpshcCt+//afU7UhhJm+SyhtEEtApVpE3qbn4mC9GN9h1iLNFeIQJ
         wfhdtMBVfPzVLMoVPjQ+Ct3EYAVcfX+Ia+olvcHdKpbczwzWxHm9ldkZ3MsVaocLENLM
         +W0A==
X-Gm-Message-State: ANhLgQ0OqRkWeXHMWw6ao13LGwL5ri/FQpbcKpffIBTZF3PRggEX3U2m
        3H+HmRu7yP5+HSJ+9gNdjH/DcQ==
X-Google-Smtp-Source: ADFU+vtIXuLKAhOxSRwmQknHK6gBQTO4ffulLvuvjqolLxIBY8IQ/C9gOq1OdEnF0L6YkCCsmh/eQw==
X-Received: by 2002:ac8:7b94:: with SMTP id p20mr5546904qtu.122.1583541260735;
        Fri, 06 Mar 2020 16:34:20 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 202sm18088610qkg.132.2020.03.06.16.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 16:34:19 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V15] mm/debug: Add tests validating architecture page table helpers
Date:   Fri, 6 Mar 2020 19:34:18 -0500
Message-Id: <CEEAD95E-D468-4C58-A65B-7E8AED91168A@lca.pw>
References: <61250cdc-f80b-2e50-5168-2ec67ec6f1e6@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
In-Reply-To: <61250cdc-f80b-2e50-5168-2ec67ec6f1e6@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Mar 6, 2020, at 7:03 PM, Anshuman Khandual <Anshuman.Khandual@arm.com> w=
rote:
>=20
> Hmm, set_pte_at() function is not preferred here for these tests. The idea=

> is to avoid or atleast minimize TLB/cache flushes triggered from these sor=
t
> of 'static' tests. set_pte_at() is platform provided and could/might trigg=
er
> these flushes or some other platform specific synchronization stuff. Just

Why is that important for this debugging option?

> wondering is there specific reason with respect to the soft lock up proble=
m
> making it necessary to use set_pte_at() rather than a simple WRITE_ONCE() ?=


Looks at the s390 version of set_pte_at(), it has this comment,
vmaddr);

/*
 * Certain architectures need to do special things when PTEs
 * within a page table are directly modified.  Thus, the following
 * hook is made available.
 */

I can only guess that powerpc  could be the same here.=

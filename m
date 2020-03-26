Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9592C1935DC
	for <lists+linux-arch@lfdr.de>; Thu, 26 Mar 2020 03:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgCZCXh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Mar 2020 22:23:37 -0400
Received: from foss.arm.com ([217.140.110.172]:55386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbgCZCXh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Mar 2020 22:23:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E6651FB;
        Wed, 25 Mar 2020 19:23:36 -0700 (PDT)
Received: from [10.163.1.31] (unknown [10.163.1.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 327E23F52E;
        Wed, 25 Mar 2020 19:23:27 -0700 (PDT)
Subject: Re: [PATCH V2 0/3] mm/debug: Add more arch page table helper tests
To:     linux-mm@kvack.org
Cc:     christophe.leroy@c-s.fr, Jonathan Corbet <corbet@lwn.net>,
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
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1585027375-9997-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2bb4badc-2b7a-e15d-a99b-b1bd38c9d9bf@arm.com>
Date:   Thu, 26 Mar 2020 07:53:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1585027375-9997-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 03/24/2020 10:52 AM, Anshuman Khandual wrote:
> This series adds more arch page table helper tests. The new tests here are
> either related to core memory functions and advanced arch pgtable helpers.
> This also creates a documentation file enlisting all expected semantics as
> suggested by Mike Rapoport (https://lkml.org/lkml/2020/1/30/40).
> 
> This series has been tested on arm64 and x86 platforms.

If folks can test these patches out on remaining ARCH_HAS_DEBUG_VM_PGTABLE
enabled platforms i.e s390, arc, powerpc (32 and 64), that will be really
appreciated. Thank you.

- Anshuman

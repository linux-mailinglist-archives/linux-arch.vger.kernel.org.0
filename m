Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D488811F90
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2019 17:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfEBPyf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 May 2019 11:54:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:43578 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfEBPyf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 May 2019 11:54:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 08:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,422,1549958400"; 
   d="scan'208";a="320874382"
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga005.jf.intel.com with ESMTP; 02 May 2019 08:54:33 -0700
Message-ID: <5b2c6cee345e00182e97842ae90c02cdcd830135.camel@intel.com>
Subject: Re: [PATCH] binfmt_elf: Extract .note.gnu.property from an ELF file
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org
Date:   Thu, 02 May 2019 08:47:06 -0700
In-Reply-To: <20190502111003.GO3567@e103592.cambridge.arm.com>
References: <20190501211217.5039-1-yu-cheng.yu@intel.com>
         <20190502111003.GO3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2019-05-02 at 12:10 +0100, Dave Martin wrote:
> On Wed, May 01, 2019 at 02:12:17PM -0700, Yu-cheng Yu wrote:
> > An ELF file's .note.gnu.property indicates features the executable file
> > can support.  For example, the property GNU_PROPERTY_X86_FEATURE_1_AND
> > indicates the file supports GNU_PROPERTY_X86_FEATURE_1_IBT and/or
> > GNU_PROPERTY_X86_FEATURE_1_SHSTK.

[...]
> A couple of questions before I look in more detail:
> 
> 1) Can we rely on PT_GNU_PROPERTY being present in the phdrs to describe
> the NT_GNU_PROPERTY_TYPE_0 note?  If so, we can avoid trying to parse
> irrelevant PT_NOTE segments.

Some older linkers can create multiples of NT_GNU_PROPERTY_TYPE_0.  The code
scans all PT_NOTE segments to ensure there is only one NT_GNU_PROPERTY_TYPE_0. 
If there are multiples, then all are considered invalid.

> 
> 
> 2) Are there standard types for things like the program property header?
> If not, can we add something in elf.h?  We should try to coordinate with
> libc on that.  Something like
> 
> typedef __u32 Elf_Word;
> 
> typedef struct {
> 	Elf_Word pr_type;
> 	Elf_Word pr_datasz;
> } Elf_Gnu_Prophdr;
> 
> (i.e., just the header part from [1], with a more specific name -- which
> I just made up).

Yes, I will fix that.

[...]
> 3) It looks like we have to go and re-parse all the notes for every
> property requested by the arch code.

As explained above, it is necessary to scan all PT_NOTE segments.  But there
should be only one NT_GNU_PROPERTY_TYPE_0 in an ELF file.  Once that is found,
perhaps we can store it somewhere, or call into the arch code as you mentioned
below.  I will look into that.

> 
> For now there is only one property requested anyway, so this is probably
> not too bad.  But could we flip things around so that we have some
> CONFIG_ARCH_WANTS_ELF_GNU_PROPERTY (say), and have the ELF core code
> call into the arch backend for each property found?
> 
> The arch could provide some hook
> 
> 	int arch_elf_has_gnu_property(const Elf_Gnu_Prophdr *prop,
> 					const void *data);
> 
> to consume the properties as they are found.
> 
> This would effectively replace the arch_setup_property() hook you
> currently have.
> 
> Cheers
> ---Dave
> 
> [1] https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI


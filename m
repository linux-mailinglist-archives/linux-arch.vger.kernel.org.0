Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A00553B9A0
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2019 18:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfFJQhM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 12:37:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:7055 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387407AbfFJQhM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jun 2019 12:37:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 09:37:11 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2019 09:37:10 -0700
Message-ID: <94b9c55b3b874825fda485af40ab2a6bc3dad171.camel@intel.com>
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an
 ELF file
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
        Borislav Petkov <bp@alien8.de>,
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
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Mon, 10 Jun 2019 09:29:04 -0700
In-Reply-To: <20190607180115.GJ28398@e103592.cambridge.arm.com>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
         <20190606200646.3951-23-yu-cheng.yu@intel.com>
         <20190607180115.GJ28398@e103592.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2019-06-07 at 19:01 +0100, Dave Martin wrote:
> On Thu, Jun 06, 2019 at 01:06:41PM -0700, Yu-cheng Yu wrote:
> > An ELF file's .note.gnu.property indicates features the executable file
> > can support.  For example, the property GNU_PROPERTY_X86_FEATURE_1_AND
> > indicates the file supports GNU_PROPERTY_X86_FEATURE_1_IBT and/or
> > GNU_PROPERTY_X86_FEATURE_1_SHSTK.
> > 
> > With this patch, if an arch needs to setup features from ELF properties,
> > it needs CONFIG_ARCH_USE_GNU_PROPERTY to be set, and a specific
> > arch_setup_property().
> > 
> > For example, for X86_64:
> > 
> > int arch_setup_property(void *ehdr, void *phdr, struct file *f, bool inter)
> > {
> > 	int r;
> > 	uint32_t property;
> > 
> > 	r = get_gnu_property(ehdr, phdr, f, GNU_PROPERTY_X86_FEATURE_1_AND,
> > 			     &property);
> > 	...
> > }
> 
> Although this code works for the simple case, I have some concerns about
> some aspects of the implementation here.  There appear to be some bounds
> checking / buffer overrun issues, and the code seems quite complex.
> 
> Maybe this patch tries too hard to be compatible with toolchains that do
> silly things such as embedding huge notes in an executable, or mixing
> NT_GNU_PROPERTY_TYPE_0 in a single PT_NOTE with a load of junk not
> relevant to the loader.  I wonder whether Linux can dictate what
> interpretation(s) of the ELF specs it is prepared to support, rather than
> trying to support absolutely anything.

To me, looking at PT_GNU_PROPERTY and not trying to support anything is a
logical choice.  And it breaks only a limited set of toolchains.

I will simplify the parser and leave this patch as-is for anyone who wants to
back-port.  Are there any objections or concerns?

Yu-cheng

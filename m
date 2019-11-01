Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F175EC4B5
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2019 15:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKAO17 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Nov 2019 10:27:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:9673 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfKAO17 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Nov 2019 10:27:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 07:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,255,1569308400"; 
   d="scan'208";a="375578378"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga005.jf.intel.com with ESMTP; 01 Nov 2019 07:27:57 -0700
Message-ID: <221c36d6646ea9f88d208dc02494872a34d8b61f.camel@intel.com>
Subject: Re: [PATCH v7 27/27] x86/cet/shstk: Add Shadow Stack instructions
 to opcode map
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Date:   Fri, 01 Nov 2019 07:17:45 -0700
In-Reply-To: <93e915b9-975d-9876-8f89-8b6f2bc4586e@intel.com>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
         <20190606200646.3951-28-yu-cheng.yu@intel.com>
         <93e915b9-975d-9876-8f89-8b6f2bc4586e@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2019-11-01 at 16:03 +0200, Adrian Hunter wrote:
> On 6/06/19 11:06 PM, Yu-cheng Yu wrote:
> > Add the following shadow stack management instructions.
> > 
> > INCSSP:
> >     Increment shadow stack pointer by the steps specified.
> > 
> > RDSSP:
> >     Read SSP register into a GPR.
> > 
> > SAVEPREVSSP:
> >     Use "prev ssp" token at top of current shadow stack to
> >     create a "restore token" on previous shadow stack.
> > 
> > RSTORSSP:
> >     Restore from a "restore token" pointed by a GPR to SSP.
> > 
> > WRSS:
> >     Write to kernel-mode shadow stack (kernel-mode instruction).
> > 
> > WRUSS:
> >     Write to user-mode shadow stack (kernel-mode instruction).
> > 
> > SETSSBSY:
> >     Verify the "supervisor token" pointed by IA32_PL0_SSP MSR,
> >     if valid, set the token to busy, and set SSP to the value
> >     of IA32_PL0_SSP MSR.
> > 
> > CLRSSBSY:
> >     Verify the "supervisor token" pointed by a GPR, if valid,
> >     clear the busy bit from the token.
> 
> Does the notrack prefix also need to be catered for somehow?

Yes, I will fix it.

> 
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > ---
> >  arch/x86/lib/x86-opcode-map.txt               | 26 +++++++++++++------
> >  tools/objtool/arch/x86/lib/x86-opcode-map.txt | 26 +++++++++++++------
> >  2 files changed, 36 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
> > index e0b85930dd77..c5e825d44766 100644
> > --- a/arch/x86/lib/x86-opcode-map.txt
> > +++ b/arch/x86/lib/x86-opcode-map.txt
> > @@ -366,7 +366,7 @@ AVXcode: 1
> >  1b: BNDCN Gv,Ev (F2) | BNDMOV Ev,Gv (66) | BNDMK Gv,Ev (F3) | BNDSTX Ev,Gv
> >  1c:
> >  1d:
> > -1e:
> > +1e: RDSSP Rd (F3),REX.W
> >  1f: NOP Ev
> >  # 0x0f 0x20-0x2f
> >  20: MOV Rd,Cd
> > @@ -610,7 +610,17 @@ fe: paddd Pq,Qq | vpaddd Vx,Hx,Wx (66),(v1)
> >  ff: UD0
> >  EndTable
> >  
> > -Table: 3-byte opcode 1 (0x0f 0x38)
> > +Table: 3-byte opcode 1 (0x0f 0x01)
> > +Referrer:
> > +AVXcode:
> > +# Skip 0x00-0xe7
> > +e8: SETSSBSY (f3)
> > +e9:
> > +ea: SAVEPREVSSP (f3)
> > +# Skip 0xeb-0xff
> > +EndTable
> > +
> > +Table: 3-byte opcode 2 (0x0f 0x38)
> >  Referrer: 3-byte escape 1
> >  AVXcode: 2
> >  # 0x0f 0x38 0x00-0x0f
> > @@ -789,12 +799,12 @@ f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
> >  f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
> >  f2: ANDN Gy,By,Ey (v)
> >  f3: Grp17 (1A)
> > -f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
> > -f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
> > +f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v) | WRUSS Pq,Qq (66),REX.W
> > +f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSS Pq,Qq (66),REX.W
> 
> AFAICT WRSS does not have 66 prefix

I will check.

Thanks,
Yu-cheng

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD78D812
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2019 18:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfHNQaB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Aug 2019 12:30:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:19771 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfHNQaB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Aug 2019 12:30:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 09:30:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,385,1559545200"; 
   d="scan'208";a="178211198"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2019 09:30:00 -0700
Message-ID: <699fe0a2c2331af0d45a3516d9422d5ed5b59a99.camel@intel.com>
Subject: Re: [PATCH v8 09/27] mm/mmap: Prevent Shadow Stack VMA merges
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
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
Date:   Wed, 14 Aug 2019 09:20:21 -0700
In-Reply-To: <5ba3d1b3-5587-e7dd-b9de-9a954172d31f@intel.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
         <20190813205225.12032-10-yu-cheng.yu@intel.com>
         <5ba3d1b3-5587-e7dd-b9de-9a954172d31f@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2019-08-13 at 15:34 -0700, Dave Hansen wrote:
> On 8/13/19 1:52 PM, Yu-cheng Yu wrote:
> > To prevent function call/return spills into the next shadow stack
> > area, do not merge shadow stack areas.
> 
> How does this prevent call/return spills?

It does not.  I will fix the description.

Yu-cheng

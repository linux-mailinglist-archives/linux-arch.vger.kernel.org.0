Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291B1173CA6
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 17:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgB1QQJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Feb 2020 11:16:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:51515 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgB1QQJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Feb 2020 11:16:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 08:16:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="261900316"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga004.fm.intel.com with ESMTP; 28 Feb 2020 08:16:09 -0800
Message-ID: <e35cc25c4ba1dcb4154276b1e2731891a3c600ec.camel@intel.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Date:   Fri, 28 Feb 2020 07:55:33 -0800
In-Reply-To: <202002251159.939AA6A@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-2-yu-cheng.yu@intel.com>
         <202002251159.939AA6A@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-02-25 at 12:02 -0800, Kees Cook wrote:
> On Wed, Feb 05, 2020 at 10:19:09AM -0800, Yu-cheng Yu wrote:
> > Explain no_cet_shstk/no_cet_ibt kernel parameters, and introduce a new
> > document on Control-flow Enforcement Technology (CET).
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> I'm not a huge fan of the boot param names, but I can't suggest anything
> better. ;) I love the extensive docs!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for reviewing!

Yu-cheng


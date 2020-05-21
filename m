Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153BC1DDA97
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 00:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgEUW6I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 May 2020 18:58:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:41812 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgEUW6I (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 May 2020 18:58:08 -0400
IronPort-SDR: m/+JG8SNOxRB8o0q7/vu90Fi3Q8SIYcsTs2xydLaOyDZrqGPDRV0aXmWxvJdeDnZsry5z0S4EM
 +q6eVYZdHqRw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 15:58:07 -0700
IronPort-SDR: Pg/DQq+A1fZna0tY6aIC7YuoCureh5EJFUU5QUpeIJhVVZ7IF9jqkj24ksePGgTdF8N6hvK+yH
 Tc8EMpeTdWTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="300481142"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002.fm.intel.com with ESMTP; 21 May 2020 15:58:07 -0700
Message-ID: <b97aeac13967cfad5d6a962d29a87215c77996e8.camel@intel.com>
Subject: Re: [RFC PATCH 2/5] selftest/x86: Enable CET for selftests/x86
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Thu, 21 May 2020 15:58:11 -0700
In-Reply-To: <202005211544.26CD475832@keescook>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
         <20200521211720.20236-3-yu-cheng.yu@intel.com>
         <202005211544.26CD475832@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2020-05-21 at 15:44 -0700, Kees Cook wrote:
> On Thu, May 21, 2020 at 02:17:17PM -0700, Yu-cheng Yu wrote:
> > To build CET-enabled applications, GCC needs to support '-fcf-protection'.
> > Update x86 selftest makefile to detect and enable CET for x86 selftest
> > applications.
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!  I will fix issues you pointed out in the series.

Yu-cheng


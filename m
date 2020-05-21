Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5451DD985
	for <lists+linux-arch@lfdr.de>; Thu, 21 May 2020 23:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgEUVfE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 May 2020 17:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUVfE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 May 2020 17:35:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EA3C061A0E;
        Thu, 21 May 2020 14:35:04 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbspg-0002Dw-US; Thu, 21 May 2020 23:34:29 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id DE9AA100C2D; Thu, 21 May 2020 23:34:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [RFC PATCH 4/5] selftest/x86: Fix sysret_rip with ENDBR
In-Reply-To: <20200521211720.20236-5-yu-cheng.yu@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com> <20200521211720.20236-5-yu-cheng.yu@intel.com>
Date:   Thu, 21 May 2020 23:34:27 +0200
Message-ID: <878shlt1jw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Yu-cheng Yu <yu-cheng.yu@intel.com> writes:

> Insert endbr64 to assembly code of sysret_rip.

This changelog explains what the patch does, but not the WHY. It also
lacks any information why this is harmless for !CET enabled systems.

> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---

Please consult Dave Hansen about the void between your Signed-off-by
and the '---' line.

Thanks,

        tglx

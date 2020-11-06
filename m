Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6FA2A9E76
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 21:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgKFUMI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 15:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgKFUMI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2020 15:12:08 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA247C0613CF;
        Fri,  6 Nov 2020 12:12:07 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d1f00ae349cded07ea856.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1f00:ae34:9cde:d07e:a856])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1DADB1EC03EA;
        Fri,  6 Nov 2020 21:12:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604693525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nivkbud4Ws0glVwQzcGYxzOIpSJvIUSDSUkgxQshkZQ=;
        b=q4cnN6/XnuW16HM830uqd/1EXtVj5KZxz0UAu1ijjxUXxHxpBzso3/haJtlgtokwANoXHX
        pym6v36wYcMXA2ZL9ACUSEXR/knW2Iekh7tVtKKd6rpTOUHHPnP+fX9Qrp8vOxe2LSvWEx
        ObNovL8p2TBm2rLcybNSJZLds65w6ac=
Date:   Fri, 6 Nov 2020 21:11:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v14 02/26] x86/cpufeatures: Add CET CPU feature flags for
 Control-flow Enforcement Technology (CET)
Message-ID: <20201106201152.GJ14914@zn.tnic>
References: <20201012153850.26996-1-yu-cheng.yu@intel.com>
 <20201012153850.26996-3-yu-cheng.yu@intel.com>
 <20201106184953.GI14914@zn.tnic>
 <94e82db0-381b-a140-ab74-f23b7c35949e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94e82db0-381b-a140-ab74-f23b7c35949e@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 11:48:26AM -0800, Yu, Yu-cheng wrote:
> I will drop it.  It has been re-based many times, and probably I
> accidentally introduced something else?

Yah, I think I added my tag to this version:

https://lkml.kernel.org/lkml/20181119214809.6086-3-yu-cheng.yu@intel.com/

Do you need to refresh on when tags get dropped?

See here: Documentation/process/submitting-patches.rst

You should verify the rest of the patchset too - tags are not
sticked to a patch forever.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

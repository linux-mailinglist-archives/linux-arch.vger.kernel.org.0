Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5965137CFB5
	for <lists+linux-arch@lfdr.de>; Wed, 12 May 2021 19:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhELRQ6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 May 2021 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbhELQ0m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 May 2021 12:26:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77052C0612EA;
        Wed, 12 May 2021 08:56:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bb80077d55d62652951c8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b800:77d5:5d62:6529:51c8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AFF941EC0523;
        Wed, 12 May 2021 17:56:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620835012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OA2T3EfM3yuS2/g28AeCNtkAWuVuqdQFcc8kwJ1h0cQ=;
        b=kTjSthv6wlxUixi9Eb+guR9PkLPJL1RwsEu5iYG2Hgijh5pjb+n2/ok9Gk6p+CSlgBWDbN
        rxCKi8P0hxhseMjmi/Ghg82A32KwfMPftfsVz6qcqCYiF+0CignEDKIozxyVCO58/xqhh6
        FzPH9upGhKsUwfA5fiurKGIWzVQTdKQ=
Date:   Wed, 12 May 2021 17:56:49 +0200
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v26 23/30] x86/cet/shstk: Handle thread shadow stack
Message-ID: <YJv6wdnQPIJ+Uk12@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-24-yu-cheng.yu@intel.com>
 <YJlADyc/9pn8Sjkn@zn.tnic>
 <a645aefc-632f-b1eb-4f4e-1c5b0f9e75d5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a645aefc-632f-b1eb-4f4e-1c5b0f9e75d5@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 11, 2021 at 11:35:03AM -0700, Yu, Yu-cheng wrote:
> io_bitmap_share() does refcount_inc(&current->thread.io_bitmap->refcnt), and
> the function won't fail.  However, shadow stack allocation can fail.  So,
> maybe leave io_bitmap_share() at the end?

Yap, makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

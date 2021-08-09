Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF4A3E4BBF
	for <lists+linux-arch@lfdr.de>; Mon,  9 Aug 2021 20:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhHISCW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Aug 2021 14:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhHISCW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Aug 2021 14:02:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F4C0613D3;
        Mon,  9 Aug 2021 11:02:01 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26f300329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:f300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E35771EC0503;
        Mon,  9 Aug 2021 20:01:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628532116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fHWMxxdQirnkO/4OvkaqrbQ9WN12fEKkKwdCCF8n2W8=;
        b=QxQFDQ4yapDCpC7kI5Gl8w5yv/13KPaxIXDd8i8wI2u7mjgJjxSb40NT59cmR9Wl2NIIay
        wTqpiieFuZq0f+poC/hO5rsbtn8Q885A0z7c2aKGXHF8KQGxBk2A1GRMYsCI7q5Jtpv5zv
        jpCDyWuNBWxRN1UOgs08wrclD9tfsKs=
Date:   Mon, 9 Aug 2021 20:02:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
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
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v28 08/32] x86/mm: Move pmd_write(), pud_write() up in
 the file
Message-ID: <YRFtuxhNsnuBT4vq@zn.tnic>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-9-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210722205219.7934-9-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 22, 2021 at 01:51:55PM -0700, Yu-cheng Yu wrote:
> To prepare the introduction of _PAGE_COW, move pmd_write() and
> pud_write() up in the file, so that they can be used by other
> helpers below.

Add

"No functional changes."

here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

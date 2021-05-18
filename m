Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF5D386E26
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 02:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344863AbhERAQW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 20:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344843AbhERAQV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 May 2021 20:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621296904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m1Brqivodx+Oej8cFA0+U8CBPFw0wpmw/nPAdL9W5IQ=;
        b=UhGXyb/32L42UYTG3CBShV9lnqPBddrYret9hdbW+HS2sOUWKtLyz0UVQuF+AsKO1TgUdG
        WkQ+nS2Umc8kie8DL7VUKSBFArkJ1rjBJL2F/qu02tAKnVKMyfxK1Zpz3BVRuKYX3nMgrj
        rJfwiBQIwhTwsCIrEBtM14AAwaLOUZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-1urGEQsMMFWI2uB5G78gFQ-1; Mon, 17 May 2021 20:15:02 -0400
X-MC-Unique: 1urGEQsMMFWI2uB5G78gFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37867107ACCD;
        Tue, 18 May 2021 00:14:58 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20D615D6A8;
        Tue, 18 May 2021 00:14:23 +0000 (UTC)
Date:   Tue, 18 May 2021 02:14:14 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCH v26 24/30] x86/cet/shstk: Introduce shadow stack token
 setup/verify routines
Message-ID: <20210518001316.GR15897@asgard.redhat.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-25-yu-cheng.yu@intel.com>
 <YKIfIEyW+sR+bDCk@zn.tnic>
 <e225e357-a1d5-9596-8900-79e6b94cf924@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e225e357-a1d5-9596-8900-79e6b94cf924@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 17, 2021 at 01:55:01PM -0700, Yu, Yu-cheng wrote:
> On 5/17/2021 12:45 AM, Borislav Petkov wrote:
> >On Tue, Apr 27, 2021 at 01:43:09PM -0700, Yu-cheng Yu wrote:
> >>+static inline int write_user_shstk_32(u32 __user *addr, u32 val)
> >>+{
> >>+	WARN_ONCE(1, "%s used but not supported.\n", __func__);
> >>+	return -EFAULT;
> >>+}
> >>+#endif
> >
> >What is that supposed to catch? Any concrete (mis-)use cases?
> >
> 
> If 32-bit apps are not supported, there should be no need of 32-bit shadow
> stack write, otherwise there is a bug.

Speaking of which, I wonder what would happen if a 64-bit process makes
a 32-bit system call (using int 0x80, for example), and gets a signal.


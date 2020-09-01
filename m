Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D26259DA1
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 19:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgIARu5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 13:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbgIARu5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 13:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598982655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LJQ9qbxmQlGXiLqbEYSaeGjkLOhWAWXWbiUsuRzUZMg=;
        b=MgHej4kt+seujZyGpQvoqPG2yWC1yv4Wd0gGDcSRt+HQdV62ICZRBtpp9Pvzs/LFj16+k0
        /INhxhldAuOXice/vTQBLekX6yvMEiO2NY8+hHetr/nGr0OTMkPLdusmmJde378JW9uY1z
        Jwo+QJU80rXubNaNFgf7csJ/n+ogi1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-0uJb2eE_NhiqiYY54UEPVA-1; Tue, 01 Sep 2020 13:50:51 -0400
X-MC-Unique: 0uJb2eE_NhiqiYY54UEPVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02495802B7E;
        Tue,  1 Sep 2020 17:50:48 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-228.ams2.redhat.com [10.36.113.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6923B5C1BB;
        Tue,  1 Sep 2020 17:50:34 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>, Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
        <20200825002540.3351-26-yu-cheng.yu@intel.com>
        <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
        <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com>
        <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
        <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com>
        <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
        <ef7f9e24-f952-d78c-373e-85435f742688@intel.com>
        <20200826164604.GW6642@arm.com>
        <87ft892vvf.fsf@oldenburg2.str.redhat.com>
        <20200826170841.GX6642@arm.com>
        <87tuwow7kg.fsf@oldenburg2.str.redhat.com>
        <CAMe9rOrhjLSaMNABnzd=Kp5UeVot1Qkx0_PnMng=sT+wd9Xubw@mail.gmail.com>
        <873648w6qr.fsf@oldenburg2.str.redhat.com>
        <CAMe9rOqpLyWR+Ek7aBiRY+Kr6sRxkSHAo2Sc6h0YCv3X3-3TuQ@mail.gmail.com>
        <CAMe9rOpuwZesJqY_2wYhdRXMhd7g0a+MRqPtXKh7wX5B5-OSbA@mail.gmail.com>
        <3c12b6ee-7c93-dcf4-fbf7-2698003386dd@intel.com>
Date:   Tue, 01 Sep 2020 19:50:32 +0200
In-Reply-To: <3c12b6ee-7c93-dcf4-fbf7-2698003386dd@intel.com> (Yu-cheng Yu's
        message of "Tue, 1 Sep 2020 10:49:01 -0700")
Message-ID: <87o8mpqtcn.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Yu-cheng Yu:

> Like other arch_prctl()'s, this parameter was 'unsigned long'
> earlier. The idea was, since this arch_prctl is only implemented for
> the 64-bit kernel, we wanted it to look as 64-bit only.  I will change
> it back to 'unsigned long'.

What about x32?  In general, long is rather problematic for x32.

Thanks,
Florian


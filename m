Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44394AC630
	for <lists+linux-arch@lfdr.de>; Mon,  7 Feb 2022 17:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiBGQma (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 11:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382083AbiBGQcD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 11:32:03 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 08:31:57 PST
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28577C0401E8;
        Mon,  7 Feb 2022 08:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644251517; x=1675787517;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=/KVSVa7sgjsVxefcYGnYLwrI2Vchw9qvwnAjpTnywCY=;
  b=nfGJGU/w8RPiJAUoDgIgE5GRiayqDpC0pLvhcOQBB17LOJ17VbcuNbnS
   4kMZfObRf/qt9UtmrhIxohADZ0tWvv69NIu7vFI7X7XTNXy2grYiXCUQY
   gv1a5KxeeN3g+WOULH6ecpE8SEZUZOk2XN3zqWObjSO+vQt4B8Otq9MuZ
   vSmYr2sTwQVv8FWp4hLb83YFdw8p0o08HcW167NyCaXmgC5PWxyF27on1
   v9KeNsXoWg7zyk97kJ05mavsxuCwpDJzmfD9PDeI672B/AJkjsi99T5D7
   WFZ2lXWkVOuCm4eKi7IBtr08lOBREN5Jbn1fK6SSe21wod1afTwmle8K2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="232315628"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="232315628"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 08:30:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="525193372"
Received: from hgrunes-mobl1.amr.corp.intel.com (HELO [10.251.3.57]) ([10.251.3.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 08:30:53 -0800
Message-ID: <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
Date:   Mon, 7 Feb 2022 08:30:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Adrian Reber <adrian@lisas.de>, Mike Rapoport <rppt@kernel.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org> <YgDIIpCm3UITk896@lisas.de>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
In-Reply-To: <YgDIIpCm3UITk896@lisas.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/6/22 23:20, Adrian Reber wrote:
>>> 	CRIU Support
>>> 	------------
>>> 	In the past there was some speculation on the mailing list about 
>>> 	whether CRIU would need to be taught about CET. It turns out, it does. 
>>> 	The first issue hit is that CRIU calls sigreturn directly from its 
>>> 	“parasite code” that it injects into the dumper process. This violates
>>> 	this shadow stack implementation’s protection that intends to prevent
>>> 	attackers from doing this.
...
>>From the CRIU side I can say that I would definitely like to see this
> resolved. CRIU just went through a similar exercise with rseq() being
> enabled in glibc and CI broke all around for us and other projects
> relying on CRIU. Although rseq() was around for a long time we were not
> aware of it but luckily 5.13 introduced a way to handle it for CRIU with
> ptrace. An environment variable existed but did not really help when
> CRIU is called somewhere in the middle of the container software stack.
> 
>>From my point of view a solution not involving an environment variable
> would definitely be preferred.

Have there been things like this for CRIU in the past?  Something where
CRIU needs control but that's also security-sensitive?

Any thoughts on how you would _like_ to see this resolved?

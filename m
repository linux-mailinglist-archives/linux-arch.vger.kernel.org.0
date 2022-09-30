Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960E25F1244
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiI3TQx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Sep 2022 15:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiI3TQw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Sep 2022 15:16:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B21C178A0F;
        Fri, 30 Sep 2022 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664565411; x=1696101411;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Kvg1hmWTB85MGkRfrUrnIZoG1lyvNoMRxkPltDY9hDY=;
  b=f0+7LnnWGHbHp3JKFxkWhYftdonMaU5jGwf4NjcABEKRVTJQRdcwFbZB
   rIi9H6lxfFwRNrAH8KmIeOFwon6V2Cv3FWvx0knjHDPPCMfRF2lQpnfrB
   IAZRIlhJdxf0qsW/jdOLY1i5WAjjX5EIXWQRI4gDx10baGF0cMdXrhK5D
   uiFjrfPB9ECP47eEs9PvNdSYuEz/MAwPKPx6RYVr263gmdtceiNa5nfbe
   yU82F57hWCPtUuvfiIQ28Y9T77HDCkSi+ck6hIR6yP1Pv/rrHzjuu4NQk
   8S3r5BYJtCJrnsfq41155S/Iq35LjdqDN2NpW/o/CQMAbMo/sk2wyKo+d
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="328656818"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="328656818"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 12:16:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="726978714"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="726978714"
Received: from lzearing-mobl.amr.corp.intel.com (HELO [10.209.49.67]) ([10.209.49.67])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 12:16:48 -0700
Message-ID: <9fed0342-2d02-aaf2-ed66-20ff08bdfd0b@intel.com>
Date:   Fri, 30 Sep 2022 12:16:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 22/39] mm: Don't allow write GUPs to shadow stack
 memory
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-23-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220929222936.14584-23-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/29/22 15:29, Rick Edgecombe wrote:
> @@ -1633,6 +1633,9 @@ static inline bool __pte_access_permitted(unsigned long pteval, bool write)
>  {
>  	unsigned long need_pte_bits = _PAGE_PRESENT|_PAGE_USER;
>  
> +	if (write && (pteval & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY)
> +		return 0;

Do we not have a helper for this?  Seems a bit messy to open-code these
shadow-stack permissions.  Definitely at least needs a comment.

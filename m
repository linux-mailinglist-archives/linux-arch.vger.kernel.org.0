Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E0B5F3672
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 21:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJCTjF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 15:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJCTjF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 15:39:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFB02CC8E;
        Mon,  3 Oct 2022 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664825944; x=1696361944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KSXJiNJHu5j7SgNbcobNcS6+T8nWWfA9o3cdPWEIKsc=;
  b=gDotFDFcUFOdL8+Iuy9CvYMorvuOWQ4YAISgNnqFUfm4CrsajY3yKLSE
   BU2Xi6WWlslnjpEYIu0c1ZHhoy7OUHPzhA10LWB62vjQ99bKw2uh5Mxx0
   vlD7TMwXwB+lvud3YGZG4/rn3DIAjLTW4OLU6ij1rWSNx9iA3tcuHsLLr
   GCvxO+f+IRUbEYd+I5Nn2LaSOBDVY9jkdtMu4yTBBTGcBScm4O4z1u2hm
   b1TgO1TOMyyRjCNKGCZa4x7AZdXt5XSgyBFPfk+GUr+U0jOCF8CydU8S9
   5JhqH3M73BnvpWaCjZwewzTVHGhfXyVXZC1rHdYrwFgO5vb9LfUst0L7/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="389033368"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="389033368"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 12:39:03 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="574771381"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="574771381"
Received: from akashred-mobl.amr.corp.intel.com (HELO [10.212.139.217]) ([10.212.139.217])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 12:39:00 -0700
Message-ID: <fa725333-10e4-10ba-9762-add672894aba@intel.com>
Date:   Mon, 3 Oct 2022 12:39:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-2-rick.p.edgecombe@intel.com>
 <YzZlT7sO56TzXgNc@debian.me>
 <4102e1ef-c0da-37b7-6b54-89027fd9d080@nvidia.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <4102e1ef-c0da-37b7-6b54-89027fd9d080@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/3/22 12:35, John Hubbard wrote:
> It's always a judgment call, as to whether to use something like ``CALL`
> or just plain CALL. Here, I'd like to opine that that the benefits of
> ``CALL`` are very small, whereas plain text in cet.rst has been made
> significantly worse. So the result is, "this is not worth it".

I'm definitely in this camp as well.  Unless the markup *really* adds to
readability, just leave it alone.

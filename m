Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611D969DC62
	for <lists+linux-arch@lfdr.de>; Tue, 21 Feb 2023 09:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjBUItO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Feb 2023 03:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjBUItN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Feb 2023 03:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FE4227BD
        for <linux-arch@vger.kernel.org>; Tue, 21 Feb 2023 00:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676969309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wre1vj5fzLAyd/5IJIMuz7JfjlppXHl7jpGjVvaTF0=;
        b=AUtWiryng3NqUVkaqtg542iURTPqOad+aZPHzymuTABYdbSmeNxYaTYt7owRHOE0J8m5Yk
        /CinBwxqUvDnwh+W3KfGh+gsWZ7oBD2Rahf1tkByCxRIFSpjwMnsCgEjFRYhWqih0z0qUC
        1i186oCcVym1hnJiKGag9ZAAKRWIhwI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-b82JMAVoPMW6wQyWxq4qEg-1; Tue, 21 Feb 2023 03:48:25 -0500
X-MC-Unique: b82JMAVoPMW6wQyWxq4qEg-1
Received: by mail-wr1-f69.google.com with SMTP id bn1-20020a056000060100b002c5c4d8ced0so215741wrb.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Feb 2023 00:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wre1vj5fzLAyd/5IJIMuz7JfjlppXHl7jpGjVvaTF0=;
        b=pZ2vVfXvPPHOwq2h4smsLotSrEQSsPuHQTThbJgVWaLyhX8MhIJDhA9HEsjS8nCFZk
         iJLqD1gkYjd0CHOKt1lbhJ+pjnnncaNQuhJf2pYb9ItvmJX5rExIxE95RGTuzwR11iyb
         HLx+VCM6sDIpeCNWah3PxyR7cvs8Zu0quDNgQqpDKVWtbTwTrInPkvmlPIS3MeDkfQq/
         YM7XnAXmuQ4Nzco55FiIsbdbo1w62xyVIFnzG65nP7XPq61gf/zp5DpEUnO9La2OA/Tp
         QPImF6QflRBreSkk3d0BmHlmyz7NGrw0K9ILLUUZo1NjQmAEmuhiECKbT+iYM4hNuUVH
         R8Cw==
X-Gm-Message-State: AO0yUKVpIOL5hgNCzMKecOKys5IZ89hmHgTt/roA1sOdVenT6AuSy50U
        cIT05KDkfCHoQHwjRDMOQ9L/0CxG2rKoexlNYs7X++ggEfeQhNQhmmIKdxfsKSmKYf6hU42KGzb
        hHeROxltvcwHI+459T0kTAA==
X-Received: by 2002:a1c:4c14:0:b0:3de:1d31:1042 with SMTP id z20-20020a1c4c14000000b003de1d311042mr2953119wmf.23.1676969304233;
        Tue, 21 Feb 2023 00:48:24 -0800 (PST)
X-Google-Smtp-Source: AK7set8y6ZGLraGaqCxBqf1wh9ujrFtZmVaM/aUNnRhTHeMZveYItWe6AvIKaGMKcmDIyF4S+3zDiA==
X-Received: by 2002:a1c:4c14:0:b0:3de:1d31:1042 with SMTP id z20-20020a1c4c14000000b003de1d311042mr2953071wmf.23.1676969303872;
        Tue, 21 Feb 2023 00:48:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:4800:aecc:dadb:40a8:ce81? (p200300cbc7074800aeccdadb40a8ce81.dip0.t-ipconnect.de. [2003:cb:c707:4800:aecc:dadb:40a8:ce81])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c468800b003e2232d0960sm4815226wmo.23.2023.02.21.00.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 00:48:23 -0800 (PST)
Message-ID: <bed841c6-5b37-6c91-81c7-5c06788d38c4@redhat.com>
Date:   Tue, 21 Feb 2023 09:48:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        debug@rivosinc.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-38-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 37/41] selftests/x86: Add shadow stack test
In-Reply-To: <20230218211433.26859-38-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18.02.23 22:14, Rick Edgecombe wrote:
> Add a simple selftest for exercising some shadow stack behavior:
>   - map_shadow_stack syscall and pivot
>   - Faulting in shadow stack memory
>   - Handling shadow stack violations
>   - GUP of shadow stack memory
>   - mprotect() of shadow stack memory
>   - Userfaultfd on shadow stack memory
> 
> Since this test exercises a recently added syscall manually, it needs
> to find the automatically created __NR_foo defines. Per the selftest
> documentation, KHDR_INCLUDES can be used to help the selftest Makefile's
> find the headers from the kernel source. This way the new selftest can
> be built inside the kernel source tree without installing the headers
> to the system. So also add KHDR_INCLUDES as described in the selftest
> docs, to facilitate this.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---


[...]

> +bool gup_write(void *ptr)
> +{
> +	unsigned long val;
> +
> +	lseek(fd, (unsigned long)ptr, SEEK_SET);
> +	if (write(fd, &val, sizeof(val)) < 0)
> +		return 1;

/proc/self/mem is for debug/ptrace access (FOLL_FORCE). I think you 
might also want to add tests for ordinary GUP, checking that we fail to 
obtain a write pin -- and call these tests "gup_ptrace_read" / 
"gup_ptrace_write"

An simple approach would be to trigger a read()/write() on a file opened 
via O_DIRECT, using the shadow stack as buffer. While the write() 
[reading from the page] is expected to work, a read() [writing to the 
page] has to fail.


-- 
Thanks,

David / dhildenb


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE007B230B
	for <lists+linux-arch@lfdr.de>; Thu, 28 Sep 2023 18:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjI1Q6R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Sep 2023 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1Q6R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Sep 2023 12:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB3D1A3
        for <linux-arch@vger.kernel.org>; Thu, 28 Sep 2023 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695920248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=00QmXapohq3DPZCRHS2BR5NmKgg5YovRM/bSgGyBQuc=;
        b=KnxzmCSlc8aMUNB8XkFZhoga/RP7ZVBcWQd9prrvVEpOWc9ZlweOljp7gxPZ69+cKM+hJ/
        koNx4tPZvhV/Of1Tbzf9WvvxbwMS597fTwxbVnD4Xz/8pSGB1VDY+Q6qVlhhFz1nyWpfGC
        4ytmPIKm3YtHFKPf+6sL/Csw94c5nV0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-dAVQPN5qMwWqrdlneL1MZA-1; Thu, 28 Sep 2023 12:57:26 -0400
X-MC-Unique: dAVQPN5qMwWqrdlneL1MZA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32006e08483so10152909f8f.0
        for <linux-arch@vger.kernel.org>; Thu, 28 Sep 2023 09:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695920245; x=1696525045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00QmXapohq3DPZCRHS2BR5NmKgg5YovRM/bSgGyBQuc=;
        b=g7qfxUGMqEte736ZfLzqPFy+GFnDjtHp4go7hgYL7y459hy58xGky7envJWQeI7TXp
         Mzfr+80idhe0tipIse0EDkgsoaWr4hSRzsBmApeZUDyNU+bz1THvZIrSn19Y5aZCYkuc
         gOjhd300Kr/TRS/xq+J/EmJcG8Jn5fdje0klBD77XPXRBUajWIAeO8Y56PYd3Art1/af
         g1rgjdBkZlXo7oCcGRJPenASWOGSnX+tk7wwALISTm4Eps/9GI5PKHW4oIR0Vkg+q0oT
         Zb0BOT+xTZYpbKKTL9FMtu84J6EIGVZsNwQBW3X4n6MbmRtoZ4hv/QRnbp+a5MOV1che
         95Eg==
X-Gm-Message-State: AOJu0Yz4hSiosoNZNcKDijO0UfhB0dQg8rglmXSimL57UNKDBJu14+ET
        QarCAcFaRUWM2dJ0DPi5v2y3N5lJD+xImKzATppjX2+IPc97vLHTyijRB+g3SOZLm49+Fl5rhXk
        5KO79LYKE9huMNhKSfLjhjg==
X-Received: by 2002:a5d:5b17:0:b0:31f:a4fa:130a with SMTP id bx23-20020a5d5b17000000b0031fa4fa130amr2000440wrb.14.1695920245461;
        Thu, 28 Sep 2023 09:57:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdPFunf1e46tcllomSWe7BexIz1+NPtzsrILM3MPcQJWSlQc934AuWtqt00GJ12IWls8lktg==
X-Received: by 2002:a5d:5b17:0:b0:31f:a4fa:130a with SMTP id bx23-20020a5d5b17000000b0031fa4fa130amr2000414wrb.14.1695920245057;
        Thu, 28 Sep 2023 09:57:25 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id g25-20020a50d0d9000000b005361a6da384sm1474069edf.19.2023.09.28.09.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 09:57:24 -0700 (PDT)
Message-ID: <b3ed3da7-ffa3-0d35-34c1-27b159af43bb@redhat.com>
Date:   Thu, 28 Sep 2023 18:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/10] Fix confusion around MAX_ORDER
Content-Language: en-US
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, quic_jhugo@quicinc.com,
        snitzer@kernel.org, dm <dm-devel@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <3c25ec6f-cd33-9445-a76f-6ec2c30755f5@redhat.com>
 <86e7f97a-ac6b-873d-93b2-1121a464989a@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <86e7f97a-ac6b-873d-93b2-1121a464989a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/28/23 09:50, Mikulas Patocka wrote:
>>> Fix the bugs and then change the definition of MAX_ORDER to be
>>> inclusive: the range of orders user can ask from buddy allocator is
>>> 0..MAX_ORDER now.
> I think that exclusive MAX_ORDER is more intuitive in the C language -
> i.e. if you write "for (i = 0; i < MAX_ORDER; i++)", you are supposed to
> loop over all allowed values. If you declare an array "void
> *array[MAX_ORDER];" you are supposed to hold a value for each allowed
> order.
> 
> Pascal has for loops and array dimensions with inclusive ranges - and it
> is more prone to off-by-one errors.

I agree it's somewhat confusing either way but the ship has sailed, the 
patch has been included in Linux for several months.

Paolo


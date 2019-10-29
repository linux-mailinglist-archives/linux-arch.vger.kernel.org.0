Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4EFE893E
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 14:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbfJ2NSz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 09:18:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40604 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388166AbfJ2NSz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 09:18:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id p5so2427317plr.7
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pvuEzJtwy1JCp5X7vm7kUHA8B0ogZ/ZQKVMwcTk3J2c=;
        b=mMPUyzRdTbvZmttcT39vAlD8XQuSMw1OB0uhi2zQDeiKX19RuTkEzwD4DPzEKEriED
         hDXwNagfD5B6P8HaJ1YGUyexAiZ6fW+5O9p86sA7Geeq1BcrCeeyTXUMrjJquQcBDYSZ
         M58G8hECZ2Dcq5BvTUL+QsWucQWNHm0/mMCy/YWr60P702rZs1xunutr4uNVgkjNTCvN
         Wj5PFSmreN8VT5b+V3u4QTMCE5N75NCyWGB2UI4s0SMfdlD6oi1hfDACJMn+0xTzQCuN
         2jVznLsU0WIPED8xb8LmPf9XBws1styHv+jre4JrQbH4+eXB+tBV62W1HqRNMVZOqv3i
         4r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pvuEzJtwy1JCp5X7vm7kUHA8B0ogZ/ZQKVMwcTk3J2c=;
        b=QVHEI2Oydx0jcCMofqX9Aca0rE+c7x01EE9twC+ikQiOr1cqPymxi3tp+banmoltU8
         WN/c0giXq5IllVSRCD8sfWYqinL0ZNruHibYGr9lO3TwwZleUqdBiaZcjKedfr+E64lD
         Lm06xNWvs9aV4QQIT23SDKU1sSD+oSbH1o3fePelxAYkprDPia3XFtFK9wp4OAg6dn1I
         bj5LIa92hHrDK/Ywt6wcNkbnwjmLIP2RQ447XH026XWzPTfAP72fyhXFECs32bjVerRt
         tNlpa+haMX/0Y6XtQCqfEOG9rLYfN35cuP1PFD4tK/x7wL6wsEt2ii+r9egaUToB6ES1
         l8yQ==
X-Gm-Message-State: APjAAAWjqvN6qx5motmLrlXdUyYrG1RNNu9+v9Zdk3oaDkiTd82Uvm0M
        M9jWXm0ta+c6oAyKW0wfXzOGvA==
X-Google-Smtp-Source: APXvYqy9Yzd9eMDthtj14AZwGUiHvvvfwGQQB2LpKxaqTurfBAKOtYBIGduDk9lusHNW3JpAtnB4Cg==
X-Received: by 2002:a17:902:fe95:: with SMTP id x21mr3986776plm.53.1572355134404;
        Tue, 29 Oct 2019 06:18:54 -0700 (PDT)
Received: from [192.168.43.94] ([172.58.27.50])
        by smtp.gmail.com with ESMTPSA id c125sm14602926pfa.107.2019.10.29.06.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 06:18:53 -0700 (PDT)
Subject: Re: [PATCH 6/6] s390x: Mark archrandom.h functions __must_check
To:     Harald Freudenberger <freude@linux.ibm.com>,
        linux-arch@vger.kernel.org
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20191028210559.8289-1-rth@twiddle.net>
 <20191028210559.8289-7-rth@twiddle.net>
 <935cf73a-d06c-365d-131a-23dcb350ba17@linux.ibm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cd6b5b8c-77f0-ad7e-702a-27e5a929ca54@linaro.org>
Date:   Tue, 29 Oct 2019 14:18:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <935cf73a-d06c-365d-131a-23dcb350ba17@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/29/19 8:26 AM, Harald Freudenberger wrote:
> Fine with me, Thanks, reviewed, build and tested.
> You may add my reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> However, will this go into the kernel tree via crypto or s390 subsystem ?

That's an excellent question.

As an API decision, perhaps going via crypto makes more sense,
but none of the patches are dependent on one another, so they
could go through separate architecture trees.

It has been a long time since I have done much kernel work;
I'm open to suggestions on the subject.


r~

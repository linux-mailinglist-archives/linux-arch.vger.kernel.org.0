Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFE677354F
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 02:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjHHACT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 20:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHHACS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 20:02:18 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D9DDE;
        Mon,  7 Aug 2023 17:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=16M4VFQ+mwpwsQZmUC4s3uf95ihkhvpZ83i6XjHdeS0=; b=XKNlbrIbX09TZa1dazAG7fYP16
        1HHBscALoskFFfwJ4CAUjmV9R6PsyxngVPUdmVoxtJ2DgYtpYDqeceleeI7aEcsR8vsnS82/PCxLL
        f2WBM8IWvUEeid1ONt6iBHHbVy4b1bHt/4tGRLJoXebvCyY1rXbfdtUuIk8NAAEKBZtV3svkwPdXs
        iQUWBOmbIcM7LJyMERe5SgetzVyNzpm+/14eWj2OD044Wv06U3s5EJHAHxAsiaW0eXfvqh+MEM3iJ
        PCdtbOr+krwix+fNIWB5xtMMYrTz3QAoau1rIIco+o4v6fgQnKlzp0oAcPZn302GJswQLwB4iXBWb
        ykqgiafA==;
Received: from [177.45.63.19] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qTAAw-00F9hv-32; Tue, 08 Aug 2023 02:02:14 +0200
Message-ID: <8f6f78a4-d194-8443-d012-f7267a1a05c5@igalia.com>
Date:   Mon, 7 Aug 2023 21:02:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] futex: Extend the FUTEX2 flags
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, tglx@linutronix.de,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
References: <20230807121843.710612856@infradead.org>
 <20230807123322.883413972@infradead.org>
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20230807123322.883413972@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em 07/08/2023 09:18, Peter Zijlstra escreveu:
> Add the definition for the missing but always intended extra sizes,
> and add a NUMA flag for the planned numa extention.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: André Almeida <andrealmeid@igalia.com>

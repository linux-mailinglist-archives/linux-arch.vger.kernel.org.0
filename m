Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA91EF4AB
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jun 2020 11:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgFEJwA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Jun 2020 05:52:00 -0400
Received: from mail.loongson.cn ([114.242.206.163]:58990 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbgFEJv7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jun 2020 05:51:59 -0400
Received: from [10.20.42.25] (unknown [10.20.42.25])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP2mvFdpe_u89AA--.660S3;
        Fri, 05 Jun 2020 17:51:43 +0800 (CST)
Subject: Re: [PATCH 1/2] MIPS: set page access bit with pgprot on some MIPS
 platform
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <1591348266-28392-1-git-send-email-maobibo@loongson.cn>
 <20200605173909.000018ff@flygoat.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
From:   maobibo <maobibo@loongson.cn>
Message-ID: <ce625c9d-a4bb-7138-c599-62b30b65c408@loongson.cn>
Date:   Fri, 5 Jun 2020 17:51:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200605173909.000018ff@flygoat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxP2mvFdpe_u89AA--.660S3
X-Coremail-Antispam: 1UD129KBjvdXoWruFWkJF4rGF15GrWUAFWDJwb_yoWkWFX_WF
        4akr97Gw1DX34xCFsYqa1rArW8W3ykZr1Ut395Xr93t343J3ykGa1jgF9Fqw17GryIy3yv
        g347Wr4ak3WavjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxAYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkI
        ecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
        j189NUUUUU=
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 06/05/2020 05:39 PM, Jiaxun Yang wrote:
> On Fri,  5 Jun 2020 17:11:05 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> On MIPS system which has rixi hardware bit, page access bit is not
>> set in pgrot. For memory reading, there will be one page fault to
>> allocate physical page; however valid bit is not set, there will
>> be the second fast tlb-miss fault handling to set valid/access bit.
>>
>> This patch set page access/valid bit with pgrot if there is reading
>> access privilege. It will reduce one tlb-miss handling for memory
>> reading access.
>>
>> The valid/access bit will be cleared in order to track memory
>> accessing activity. If the page is accessed, tlb-miss fast handling
>> will set valid/access bit, pte_sw_mkyoung is not necessary in slow
>> page fault path. This patch removes pte_sw_mkyoung function which
>> is defined as empty function except MIPS system.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
> 
> Thanks for tracking it down.
> 
> Could you please make the patch tittle more clear?
> "Some" looks confuse to me, "systems with RIXI" would be better.

Sure, will add it.

> 
> - Jiaxun
> 


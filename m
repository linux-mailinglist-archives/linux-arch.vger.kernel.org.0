Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5386318C7
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 04:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiKUDCN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Nov 2022 22:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKUDCM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Nov 2022 22:02:12 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBA6131EC2;
        Sun, 20 Nov 2022 19:02:09 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cxbbcw6npj+AgJAA--.20171S3;
        Mon, 21 Nov 2022 11:02:08 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxoOIv6npjMmkXAA--.61033S3;
        Mon, 21 Nov 2022 11:02:08 +0800 (CST)
Subject: Re: [PATCH] tools/memory-model: Use "grep -E" instead of "egrep"
To:     Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <1668823998-28548-1-git-send-email-yangtiezhu@loongson.cn>
 <d0d2ea9e-9345-f462-b15b-edf31024f7d5@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <cf646450-c908-519b-f07a-b51c3946ad7f@loongson.cn>
Date:   Mon, 21 Nov 2022 11:02:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <d0d2ea9e-9345-f462-b15b-edf31024f7d5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxoOIv6npjMmkXAA--.61033S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFyDuF43Kr4Uur43Ww4DJwb_yoW8Kw4xpF
        WDAa4jkanIvFyUXan2ka18JF15t3Z7GF4xGry5Aa15Xrn8Wr4ayryxXF4YyFsFqFWDJw4S
        kayqvFyUJr4UC3DanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr9NsUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 11/20/2022 07:19 PM, Akira Yokosawa wrote:
> On Sat, 19 Nov 2022 10:13:18 +0800, Tiezhu Yang wrote:
>> The latest version of grep claims the egrep is now obsolete so the build
>> now contains warnings that look like:
>> 	egrep: warning: egrep is obsolescent; using grep -E
>> fix this up by moving the related file to use "grep -E" instead.
>>
>>   sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/memory-model`
>>
>> Here are the steps to install the latest grep:
>>
>>   wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
>>   tar xf grep-3.8.tar.gz
>>   cd grep-3.8 && ./configure && make
>>   sudo make install
>>   export PATH=/usr/local/bin:$PATH
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  tools/memory-model/scripts/checkghlitmus.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/memory-model/scripts/checkghlitmus.sh b/tools/memory-model/scripts/checkghlitmus.sh
>> index 6589fbb..f72816a 100755
>> --- a/tools/memory-model/scripts/checkghlitmus.sh
>> +++ b/tools/memory-model/scripts/checkghlitmus.sh
>> @@ -35,13 +35,13 @@ fi
>>  # Create a list of the C-language litmus tests previously run.
>>  ( cd $LKMM_DESTDIR; find litmus -name '*.litmus.out' -print ) |
>>  	sed -e 's/\.out$//' |
>> -	xargs -r egrep -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' |
>> +	xargs -r grep -E -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' |
>>  	xargs -r grep -L "^P${LKMM_PROCS}"> $T/list-C-already
>>
>>  # Create a list of C-language litmus tests with "Result:" commands and
>>  # no more than the specified number of processes.
>>  find litmus -name '*.litmus' -exec grep -l -m 1 "^C " {} \; > $T/list-C
>> -xargs < $T/list-C -r egrep -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' > $T/list-C-result
>> +xargs < $T/list-C -r grep -E -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' > $T/list-C-result
>>  xargs < $T/list-C-result -r grep -L "^P${LKMM_PROCS}" > $T/list-C-result-short
>>
>>  # Form list of tests without corresponding .litmus.out files
>
> Looks good to me.
>
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
>
> Paul, JFYI, this patch doesn't apply cleanly on -rcu dev due to
> a couple of changes in the lkmm-dev.2022.10.18c branch.
>
>         Thanks, Akira
>

Hi Akira,

Thanks for your review, sorry for that, let me rebase on
linux-rcu.git dev and send v2 later.

Thanks,
Tiezhu


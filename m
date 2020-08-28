Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A90255C03
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 16:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgH1OLg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 10:11:36 -0400
Received: from sjdcvmout02.udc.trendmicro.com ([66.180.82.11]:53936 "EHLO
        sjdcvmout02.udc.trendmicro.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbgH1OLX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 10:11:23 -0400
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3CCC64140;
        Fri, 28 Aug 2020 07:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
        s=tmoutbound; t=1598623882;
        bh=2leu51Oaz0HVcR63NYO/kzJM+SKH1GIG9M5l3ekm8rE=; h=From:To:Date;
        b=RnKiz1KyiZ7Mb7msAj6t+JbAwynBOxYPGFkVZQbYIzfIHLOmvv7E9xwNOOLnF9/qu
         ob0p8FsVTKVPWkyfyv74yJwtYy+9G3EAQ5O5Wpi0Iw44zCeSXOFpvq5FcbJ+SbB2Bd
         Y99FfSQwxoYIye6cZdNAhD5O7eo1G3kNyMYLz/q0=
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4DA46413E;
        Fri, 28 Aug 2020 07:11:21 -0700 (PDT)
Received: from SJDC-EXNABU02.us.trendnet.org (unknown [10.45.175.98])
        by sjdcvmout02.udc.trendmicro.com (Postfix) with ESMTPS;
        Fri, 28 Aug 2020 07:11:21 -0700 (PDT)
Received: from ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) by
 SJDC-EXNABU02.us.trendnet.org (10.45.175.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Fri, 28 Aug 2020 07:11:21 -0700
Received: from ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) by
 ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Fri, 28 Aug 2020 14:11:18 +0000
Received: from ADC-EXAPAC11.tw.trendnet.org ([fe80::35d2:8fa6:df0c:6aae]) by
 ADC-EXAPAC11.tw.trendnet.org ([fe80::35d2:8fa6:df0c:6aae%18]) with mapi id
 15.01.1979.003; Fri, 28 Aug 2020 14:11:18 +0000
From:   "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "cameron@moodycamel.com" <cameron@moodycamel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: RE: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
Thread-Topic: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
Thread-Index: AQHWfI4t/nsBli3py0KTZQaFFkmSRalNd/2QgAATfICAAAMrMA==
Date:   Fri, 28 Aug 2020 14:11:18 +0000
Message-ID: <23d43cfb12c54a1fbc766ea313ecb5a6@trendmicro.com>
References: <20200827161237.889877377@infradead.org>
        <20200827161754.359432340@infradead.org>
        <7df0a1af432040d9908517661c32dc34@trendmicro.com>
 <20200828225113.9541a5f67a3bcb17c4ce930c@kernel.org>
In-Reply-To: <20200828225113.9541a5f67a3bcb17c4ce930c@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.4.6]
X-TM-AS-Product-Ver: IMSVA-9.1.0.1960-8.6.0.1013-25630.007
X-TM-AS-Result: No--15.421-5.0-31-10
X-TMASE-MatchedRID: SIg5fOCPFH/UL3YCMmnG4vHkpkyUphL9AQ8mtiWx//puOTbkZwMFPMAS
        M1FbRaAi6cwIJjeKGkyxpjy1K0tDfrotpw4iUQe/nMQdNQ64xffvYEK+8qVVeyVT1SRkUxgNy5M
        gwQconH7maxj3gZnVdLj6+m60PQeTfrUrtN2hvziprpImTnz4toBOBQVQ0d5DPKi9LCfAVUAhIX
        hZYzDXgRT+Wo2YXV/HWh0AAsriQA5jc+aKf+OtsZcSOzDC4nqrrMQfIfGe10YWtW/EiS01n6goI
        qR4kS6O3o52a+i4d4shqqvfYyVVpUKPluOEKT3/N19PjPJahlJq7v1YYMsJ6Qzvg1/q1MH2WHq1
        bpSh5eILlAT8wIANSWcMD7m4XaqJOC4YD94VucDvVbHa5Rs8twVyeo9hM9SH6wwa/hhtmlajxYy
        RBa/qJR8AKgKWeNGh5MIx11wv+COQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.421400-10.000000
X-TMASE-Version: IMSVA-9.1.0.1960-8.6.1013-25630.007
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-SNTS-SMTP: BD6DD143CF0EB167BA3D0FDE2E9BB2C86D21459032A1C785F2EC4FB8BD90EFB12000:8
X-TM-AS-GCONF: 00
X-imss-scan-details: No--15.421-5.0-31-10
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Masami Hiramatsu <mhiramat@kernel.org>
>
> OK, schedule function will be the key. I guess the senario is..
>
> 1) kretporbe replace the return address with kretprobe_trampoline on task=
1's kernel stack
> 2) the task1 forks task2 before returning to the kretprobe_trampoline
> 3) while copying the process with the kernel stack, task2->kretprobe_inst=
ances.first =3D NULL

I think new process created by fork/clone uses a brand new kernel stack? I =
thought only user stack are copied.
Otherwise any process launch should crash in the same way

By the way, I can reproduce this on the latest branch(v4)
TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidential=
 and may be subject to copyright or other intellectual property protection.=
 If you are not the intended recipient, you are not authorized to use or di=
sclose this information, and we request that you notify us by reply mail or=
 telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please see =
our Privacy Notice on our website at: Read privacy policy<http://www.trendm=
icro.com/privacy>

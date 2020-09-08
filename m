Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF518261087
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgIHLPi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 07:15:38 -0400
Received: from sjdcvmout02.udc.trendmicro.com ([66.180.82.11]:54546 "EHLO
        sjdcvmout02.udc.trendmicro.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729538AbgIHLPd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 07:15:33 -0400
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87A2364061;
        Tue,  8 Sep 2020 04:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
        s=tmoutbound; t=1599563730;
        bh=++mVKGI+xYg8x1TKt6F/Pb/EdbEZ8O0gXXZ5vJmBZu0=; h=From:To:Date;
        b=ScwUXwqBSco0tRkelinqY4GPtVg+rsX8oV31jwrgdjPB2S2UlVi3RZJY6LIEi79GN
         CF/OTrdcG3jUlDg9D7KfDHbl9bOVUOhza/5Fj0rMeDVgDn3eG7RVnilZsZj5yLP4GT
         W1WGIZxw064mATbyVIUq3iW+OKv1mEZi3otGXSvQ=
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7462864089;
        Tue,  8 Sep 2020 04:15:19 -0700 (PDT)
Received: from SJDC-EXNABU01.us.trendnet.org (unknown [10.45.175.97])
        by sjdcvmout02.udc.trendmicro.com (Postfix) with ESMTPS;
        Tue,  8 Sep 2020 04:15:19 -0700 (PDT)
Received: from ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) by
 SJDC-EXNABU01.us.trendnet.org (10.45.175.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Tue, 8 Sep 2020 04:15:18 -0700
Received: from ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) by
 ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Tue, 8 Sep 2020 11:15:14 +0000
Received: from ADC-EXAPAC11.tw.trendnet.org ([fe80::35d2:8fa6:df0c:6aae]) by
 ADC-EXAPAC11.tw.trendnet.org ([fe80::35d2:8fa6:df0c:6aae%18]) with mapi id
 15.01.1979.003; Tue, 8 Sep 2020 11:15:14 +0000
From:   "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     Ingo Molnar <mingo@kernel.org>,
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
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "systemtap@sourceware.org" <systemtap@sourceware.org>
Subject: RE: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers and
 make kretprobe lockless
Thread-Topic: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Thread-Index: AQHWfgRSCESp9PK2qEmaIhlcIgCeUqlUKmsAgABcEYCAAGuCAIAAFReAgAAV4YCAAD5dAIAABowAgADIVwCACHHjAIAACFxw
Date:   Tue, 8 Sep 2020 11:15:14 +0000
Message-ID: <dd1b7b1fdbd84d20ad06abf0c06b4747@trendmicro.com>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
 <20200901190808.GK29142@worktop.programming.kicks-ass.net>
 <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
 <20200902070226.GG2674@hirez.programming.kicks-ass.net>
 <20200902171755.b126672093a3c5d1b3a62a4f@kernel.org>
 <20200902093613.GY1362448@hirez.programming.kicks-ass.net>
 <20200902221926.f5cae5b4ad00b8d8f9ad99c7@kernel.org>
 <20200902134252.GH1362448@hirez.programming.kicks-ass.net>
 <20200903103954.68f0c97da57b3679169ce3a7@kernel.org>
 <20200908103736.GP1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200908103736.GP1362448@hirez.programming.kicks-ass.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.4.6]
X-TM-AS-Product-Ver: IMSVA-9.1.0.1960-8.6.0.1013-25652.006
X-TM-AS-Result: No--13.579-5.0-31-10
X-TMASE-MatchedRID: fisHOP3cX1jUL3YCMmnG4vHkpkyUphL9+IfriO3cV8QviP3/DuH032lF
        7OhYLlct0Rucqr17Y/YsrJ6YgF1+HBZRzAmpIJedwS8qUbQKOMihlQaHv8lv4KosuYcc0VWUa3A
        6hcNu8nADh7qzot0BF+xeaIGweo11L3vAnkncsWmtBybNxXyi/BmyTBaqiJvc7649n0TgA4k7yU
        iWtMo7o0SE6cDIXfLWysK+7TtkkV25UpxrNQf5nQD9gX5aXd4fQABNUkvqrhfLmsnRFz6pJtEYh
        xNoldm1jqkhdl7xWKbGYTYwx24fmXj7PwsdQyXdiPIR0a1i6hdXgkPfc7vKCTUQfiU3MhlIJ+BT
        0Y87Csa57ZGjIWPrVAd2m1cUUwTvx5913wav7nCeAiCmPx4NwMidYBYDjITpiaHgegYo0SFQSFb
        L1bvQASAHAopEd76v+1E8TAkVzxP6hSgEB93zX1y02L/cQu0IFfJSa/VY7qoYCl8nGW1v6w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.578500-10.000000
X-TMASE-Version: IMSVA-9.1.0.1960-8.6.1013-25652.006
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-SNTS-SMTP: AC371C619D3FD3B46CDA1403A38D828A0D8DCA31EB0E32DE45CA391C53DF4B872000:8
X-TM-AS-GCONF: 00
X-imss-scan-details: No--13.579-5.0-31-10
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: peterz@infradead.org <peterz@infradead.org>
>
> I'm now trying and failing to reproduce.... I can't seem to make it use
> int3 today. It seems to want to use ftrace or refuses everything. I'm
> probably doing it wrong.
>

You can turn off CONFIG_KPROBES_ON_FTRACE (and also sysctl debug.kprobes-op=
timization) to make it use int3 handler


TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidential=
 and may be subject to copyright or other intellectual property protection.=
 If you are not the intended recipient, you are not authorized to use or di=
sclose this information, and we request that you notify us by reply mail or=
 telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please see =
our Privacy Notice on our website at: Read privacy policy<http://www.trendm=
icro.com/privacy>

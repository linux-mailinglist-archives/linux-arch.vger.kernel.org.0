Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40B5AAAEAF
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2019 00:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391298AbfIEWrT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Sep 2019 18:47:19 -0400
Received: from mail-eopbgr720114.outbound.protection.outlook.com ([40.107.72.114]:24931
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730937AbfIEWrS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Sep 2019 18:47:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FprjkEqfeHyZBuu5gUk38wRg8CR0ozPsDJ0NeT/aOxG3VySvQmSGURE+BB9sTgL2AC0TSh5ArA419yBZuvpwEuHPfgps1kQcfxCSp6asNZkA/cM4JEwY2OdgfiuFRx730l7jjs4OfBHGATedq6iHOQG28+KP8TMoYvEDh3iGtgn8i48ITvHngk9I4sXMZ37hJ1Kgrn8tTMKubi8lCS410PnLS7qsdm73Busc76Nk7TrWGcKO4GJN/Tvxs/pi0SpgPx82EU1k8U4UbdPHkGpnk41PMEbbDyJxIr9fKcOZHbXocc0Kfe/izE348vRaqKCZfk2erfDckk/+WyciUbSFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORw0iwaw/0Cfg+x0H8A2QBn8yDHJwvQQmPPoFmNMd3I=;
 b=LMt8Dnk9ZtKNfL3AKta9PTtWPX407d+eS/g1LVzZPEMjVen79r0/FOyjvg54Baef4kRK0yyKEa6VpKFgcIo92F1UXPr0yjz0b8JH3rlqauYMAbPU8ftkgLH5qUvJIe6OoEebytH/bt0G3aaxt6pF0XSnKRNB1Nne9z84TPkPimpHxEr2bEJ58cOJhYi/6e6r0/ULW+mMaGFs9JWYLtq5MS5Q0ysHYJNpNdFSdLy1qxadV4RAr8N6WkShVtb4Y20sIT4Jj7VKEryHGhTCuQ1xq2LUjYJzK7d2lF4fYBE+4qMD9ayA2oVTkGhnItQvSv1kVyvLSNE1IoOkszLNYnr8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORw0iwaw/0Cfg+x0H8A2QBn8yDHJwvQQmPPoFmNMd3I=;
 b=Rt7NqldZp1gN1nZbF3NTS5iYTqDFjL8cEjjcBg9VkHfmtFIFmW6CEj7fsG2ipEg4Aax5AerI/RTxyby816wvxUOfV94BzcvEHC3C2DaAYRIZgVTFmQDnkvfJ3V54TcE7nDhNWKGaOCyNRERcDQNdeXpUemCAb2sCm++AuJh15YM=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1101.namprd21.prod.outlook.com (52.132.115.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.7; Thu, 5 Sep 2019 22:47:14 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 22:47:14 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 2/3] x86/hyper-v: Implement hv_is_hibernation_supported()
Thread-Topic: [PATCH v5 2/3] x86/hyper-v: Implement
 hv_is_hibernation_supported()
Thread-Index: AQHVZDvcU8cR6ajeoU+/WC5ul/Z50w==
Date:   Thu, 5 Sep 2019 22:47:14 +0000
Message-ID: <1567723581-29088-3-git-send-email-decui@microsoft.com>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567723581-29088-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0019.namprd19.prod.outlook.com
 (2603:10b6:300:d4::29) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68a3c0db-fb21-416e-a12e-08d73252fec3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1101;
x-ms-traffictypediagnostic: SN6PR2101MB1101:|SN6PR2101MB1101:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1101AF10A8E4D68EF5A5AD4BBFBB0@SN6PR2101MB1101.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(4326008)(36756003)(6512007)(25786009)(99286004)(6436002)(7416002)(81156014)(81166006)(8676002)(53936002)(386003)(76176011)(6506007)(107886003)(6636002)(4720700003)(316002)(54906003)(110136005)(50226002)(22452003)(8936002)(52116002)(3450700001)(66066001)(2906002)(2501003)(43066004)(1511001)(10090500001)(66476007)(86362001)(66556008)(64756008)(26005)(66946007)(66446008)(3846002)(6116002)(2201001)(305945005)(2616005)(11346002)(71200400001)(476003)(102836004)(446003)(14444005)(256004)(71190400001)(5660300002)(478600001)(10290500003)(6486002)(7736002)(14454004)(486006)(186003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1101;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k7T+CvbLocWURWaA2dmN7SLXboIyfZG3y5xknpRRkQGAGoQLDOfTk00+YNN1PLsGn+hbAvwKeuovL4Jm9ZlXapHbgEQxfSbNcavVeKPXScrIyxIjPBVuznVq0T85iZpglXdvrSGVXCXyCTWeSHvvk/hXEhHmMQHpgdD3HAX8Ykye4Y3abw7R+8/Aow8sY5Ioo/XuRfDggW2bN7Ubr7BBcTs8AsKoSxMkduuC/aRyVNXCeikLQA8DtIrN4Z2x2dFSdwje5HkdC6HFa5/D5KFLH09Z+gKW8FEIP7mmysWW4scDAkI8BIf5S649g8ku2emIn0/d51ZK5oMsZS1ENvSDfmgJJPAq/VjSqEEAGMFHkNNz7GSStN79Tx6cqo2Ai5wOtHyVkRnqN6QO4L+TwCVcHM7bTDvHAohzcqyczMxGsXg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a3c0db-fb21-416e-a12e-08d73252fec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 22:47:14.1383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZ/6AEx/uWF3NgHLsrc2oFyuOiLlERWVt2FRHiRe60O6mBaTt9rsJZdtfvQWnheiUum1V+aX7wULVjFtPAYFZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1101
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The API will be used by the hv_balloon and hv_vmbus drivers.

Balloon up/down and hot-add of memory must not be active if the user
wants the Linux VM to support hibernation, because they are incompatible
with hibernation according to Hyper-V team, e.g. upon suspend the
balloon VSP doesn't save any info about the ballooned-out pages (if any);
so, after Linux resumes, Linux balloon VSC expects that the VSP will
return the pages if Linux is under memory pressure, but the VSP will
never do that, since the VSP thinks it never stole the pages from the VM.

So, if the user wants Linux VM to support hibernation, Linux must forbid
balloon up/down and hot-add, and the only functionality of the balloon VSC
driver is reporting the VM's memory pressure to the host.

Ideally, when Linux detects that the user wants it to support hibernation,
the balloon VSC should tell the VSP that it does not support ballooning
and hot-add. However, the current version of the VSP requires the VSC
should support these capabilities, otherwise the capability negotiation
fails and the VSC can not load at all, so with the later changes to the
VSC driver, Linux VM still reports to the VSP that the VSC supports these
capabilities, but the VSC ignores the VSP's requests of balloon up/down
and hot add, and reports an error to the VSP, when applicable. BTW, in
the future the balloon VSP driver will allow the VSC to not support the
capabilities of balloon up/down and hot add.

The ACPI S4 state is not a must for hibernation to work, because Linux is
able to hibernate as long as the system can shut down. However in practice
we decide to artificially use the presence of the virtual ACPI S4 state as
an indicator of the user's intent of using hibernation, because Linux VM
must find a way to know if the user wants to use the hibernation feature
or not.

By default, Hyper-V does not enable the virtual ACPI S4 state; on recent
Hyper-V hosts (e.g. RS5, 19H1), the administrator is able to enable the
state for a VM by WMI commands.

Once all the vmbus and VSC patches for the hibernation feature are
accepted, an extra patch will be submitted to forbid hibernation if the
virtual ACPI S4 state is absent, i.e. hv_is_hibernation_supported() is
false.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c      | 7 +++++++
 include/asm-generic/mshyperv.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 037b0f3..9a26071 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -7,6 +7,7 @@
  * Author : K. Y. Srinivasan <kys@microsoft.com>
  */
=20
+#include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/types.h>
 #include <asm/apic.h>
@@ -450,3 +451,9 @@ bool hv_is_hyperv_initialized(void)
 	return hypercall_msr.enable;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+bool hv_is_hibernation_supported(void)
+{
+	return acpi_sleep_state_supported(ACPI_STATE_S4);
+}
+EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.=
h
index 18d8e2d..b3f1082 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -166,10 +166,12 @@ static inline int cpumask_to_vpset(struct hv_vpset *v=
pset,
 void hyperv_report_panic(struct pt_regs *regs, long err);
 void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
+bool hv_is_hibernation_supported(void);
 void hyperv_cleanup(void);
 void hv_setup_sched_clock(void *sched_clock);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
+static inline bool hv_is_hibernation_supported(void) { return false; }
 static inline void hyperv_cleanup(void) {}
 #endif /* CONFIG_HYPERV */
=20
--=20
1.8.3.1


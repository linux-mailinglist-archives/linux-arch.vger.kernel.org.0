Return-Path: <linux-arch+bounces-9133-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294AF9D091F
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 06:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF61E1F218CB
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2024 05:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153B145FE8;
	Mon, 18 Nov 2024 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1wy9/lhV"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F248713DBBE;
	Mon, 18 Nov 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909162; cv=fail; b=GIAQ3t41ZB6bz9eCKbP5mVPOKbuTC13pXAP1u9M0Gmp2zET/RisFRDDtJ2+TDkALcQTLk4u727C6wDIH47zb/2bu49BIWSXRPYCpAO2bQWl0PlbOVBttEkMf/Z9XX2tZslbZ+3xyx8bQWAxtpm9JYiD+j9UIlZymVfLweZYL2Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909162; c=relaxed/simple;
	bh=Qzze4hijCZox1PHcYdbSWXDAP0hIN4VM5hZfyhVk/10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJbP9s9OTJc7XKaT0PDQqKGUXe9EDFXAy44zw03HRpbyYWOwNnZJOV1GeAEefJtRYlcwpLaWetr3IN0x5tHCfyDng2iZaQiPq+FHs8T4Pv4Fbf1BWPGS03aK9MgXU/M0ODK/aruy6yp+w6QSfMJ014OGl4Bi0abch8gxT+1zWO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1wy9/lhV; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjSQUQqPBkj7C+jtBgj/dHvYzOmM6Uwey4Tz5Jd9dccpPJBpfGElRJ+nheQhaDFAw9BWLyo9ktElie/MNb9Ltqu24g0E2z3V9o3n7vIr4Ydu2evtnTSaI5V6L7dfm9L4+anXBzEVhgOiENhlpRYaiag4pQXg6uroHt0EDZSui4yLoP3LIKqBZdDHoSF46h6/Sbjph7rBcuq9XABpiGKoJayYdb/dmHm6nhZCWfOi3AVJkMRKyKIbqzKd4TNImzms2BXbW2C6+Tm/ocHh/jxkftfvCvIvNyBSv+sKCqJ0Zc1dw8mUOE9yddO4mWOB3MT9AgteChDRxH0OXAGSaK2ZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWlbuZDcMpQ2WcHN6hYp5+jqgZsY70m+sNGyDJu8kXI=;
 b=p4UjXzsnM9YlJyoUK+YXgjhupvaN6DhsD8jFiOEFRK4zZtSuij5shzMRpHCqaDv9NnbVIJeLl15nS1xXAnYilbWJ3xXgA3Ry+yjLrOwy2HDCi2n1/pyR7UwMmVWfIVrvuPHEPfm39P/BpHRXnEz3ItdzNU9qHG44hzHekWt/+7J6r+IAXIpKxyqh02jViZcyMK67qSod6FqP3uV4cedaqTFQT2KNB0bOvCzVHRueCIEyvc4+l04oVOnqbdR1jbDae9xKgDQW+mnJn2ZHi9MgQ7+ulGd1lQHrUcUOob1JIyF/ZmEYCW15E4j6/GPPvKPxxGcZQCV0g6HyaRSevoCYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWlbuZDcMpQ2WcHN6hYp5+jqgZsY70m+sNGyDJu8kXI=;
 b=1wy9/lhVLzuyhOvycWc6rtVHTnAa988v8gJH1N1VRatVxxl04BQz8uNYYLD10w0dgPlKEFxXoY7mRdpjeBIDuXPTFtaSFOZKdCqIYjmKFoWZ5JbPKzhSxQNW6pT+mGl47MIP9ZptDts0PcNQ3ZYGXdDv13kqZ1kj6lUhmGRPaIk=
Received: from MN2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:208:1b4::36)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Mon, 18 Nov
 2024 05:52:37 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:1b4:cafe::c5) by MN2PR15CA0023.outlook.office365.com
 (2603:10b6:208:1b4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend Transport; Mon,
 18 Nov 2024 05:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Mon, 18 Nov 2024 05:52:36 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:50:23 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<arnd@arndb.de>, <ubizjak@gmail.com>, <linux-arch@vger.kernel.org>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v12 6/9] iommu/amd: Introduce helper function get_dte256()
Date: Mon, 18 Nov 2024 05:49:34 +0000
Message-ID: <20241118054937.5203-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118054937.5203-1-suravee.suthikulpanit@amd.com>
References: <20241118054937.5203-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f938d3a-1820-4f35-c13a-08dd0795347d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r20w2xO3Fb6+CAie/XLIS9y46vSPrUybUYYtdh3vsoSwd0vqCiOGesQ+VtVg?=
 =?us-ascii?Q?PWqhgm7CU3JteEee4fBK4fBKfLo3iZKqX6D8CE7S9AjSL30HLylpL6IweogC?=
 =?us-ascii?Q?U+6iUF5DVPwh4huqg1/k0T6hnlAOadBSlnOkBMKw1xGzLTtQk/1WPHSvwd6J?=
 =?us-ascii?Q?eGo4jPQCn5zBKvwf1v0xxUqbRqyh4Gxo/g8ecDbWTNYPv64+lrUCRhthrOHw?=
 =?us-ascii?Q?AfixK3rFA7WDcYhnyFFtzSXSvceUFaAri/QGAquvME2Uaa0ot8lyyksEf941?=
 =?us-ascii?Q?+Pc+1CYuZUM3QKF3V8gay+pKYBxCrr+HVh7YFAh9FcWEIais25+s8Ok6x5vc?=
 =?us-ascii?Q?BVMti+JdLaj8JZTcr4kYb/E3jKt0rwP1ILAXZdE5Cb3rw9lyuhfl1DUqua6W?=
 =?us-ascii?Q?GdPqsWHOmL5vZI6fXzd4JoO00UsB/i25adznIvVnWYrMQlUSmhsCVakfec42?=
 =?us-ascii?Q?Hg0QEqY7EsJ88qFKomovUxX/XVqgivoCuGryazqiHW+7mefyl5CHC2t82rrJ?=
 =?us-ascii?Q?5YaIM92R5W7EKTaBEqXnTH3Yu0C+6kpXyH06vjPFOaKZxa273yp1uSl4gsRY?=
 =?us-ascii?Q?JhjA8dofCy5CNS306yAXs+HBTz1wBeIkclRY1ogVuCx6Syx+tcr++MOiN/2D?=
 =?us-ascii?Q?wFfYPEsuayiFockfiHh0wM0f9enowjUFTHJ8LSuqf9n4BglpeBKXy4Ngs+GW?=
 =?us-ascii?Q?40sBueRObyrsRC21nQXpDpAP5oeOBZNq3WIx38ZpmP8lB/brrMTZRNa6Qcrd?=
 =?us-ascii?Q?WxSI75u1HQnZJ5tTWb2swykNEacpExDVDEMCv98MwLY/kd2L7MdZWAdj0Wbb?=
 =?us-ascii?Q?nxmSnzs1RNZ3cyQDN3thWNS3zp9EHVblpzClTJzfOIMSLOx1XRAYNWYDaq9r?=
 =?us-ascii?Q?4bLEyEApj0o227Ur9kxpy1harZ0qaMBN2yqPCqiLRAul7F8BkODvWG4oyGHb?=
 =?us-ascii?Q?0d1XujW1IrcxCyngQkW74/vm0LgPSw7fyfqz5nFE1QoPwuVGkV+fJH3EeNRw?=
 =?us-ascii?Q?jvpA3SnQFVkPRD5UUMn7TFEAB8ZgS0RAVM0b0AdOrO6/7M6a3FEXCqmoXbjS?=
 =?us-ascii?Q?k9vSShxYL7pZafFsRQXZRoSJh2oxN+1AfWj69wuAotIYSW8Vi5AUk6M18Rp+?=
 =?us-ascii?Q?JQc0ysi8WTxxpJsQtruajM2bsFb45eX5Z9ZUPR/ERdJhDxFXZCBsyjljZa5q?=
 =?us-ascii?Q?eXEHLxRFZhMXMf+KIdaOb/wCRGiSh9yCI+bW45P2fUKxwrJhwrNsjPqsmOAz?=
 =?us-ascii?Q?wfAxWeqR7CGbP2W41MbKSwvEhkSBMSerMmq1XxKAMCKjJIyBXSms0Dfvs2Rp?=
 =?us-ascii?Q?MIXxISAMoJbSxlvR8aYAoyaFrhrqXxz+dlKp0afIVtsyocLhl4Hjftsosuq0?=
 =?us-ascii?Q?ihNdWCBYgnRP97MqZNvxQPsEnulzUpWG8Sz+lQmbUeoJmA9xIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:52:36.8006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f938d3a-1820-4f35-c13a-08dd0795347d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

And use it in clone_alias() along with update_dte256().
Also use get_dte256() in dump_dte_entry().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 62 ++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fd69153e64e6..a1ed8d3b3887 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -85,6 +85,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
 
+static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid);
+
 /****************************************************************************
  *
  * Helper functions
@@ -202,6 +204,21 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 	spin_unlock_irqrestore(&dev_data->dte_lock, flags);
 }
 
+static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
+		      struct dev_table_entry *dte)
+{
+	unsigned long flags;
+	struct dev_table_entry *ptr;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	ptr = &dev_table[dev_data->devid];
+
+	spin_lock_irqsave(&dev_data->dte_lock, flags);
+	dte->data128[0] = ptr->data128[0];
+	dte->data128[1] = ptr->data128[1];
+	spin_unlock_irqrestore(&dev_data->dte_lock, flags);
+}
+
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
@@ -350,9 +367,11 @@ static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid
 
 static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
+	struct dev_table_entry new;
 	struct amd_iommu *iommu;
-	struct dev_table_entry *dev_table;
+	struct iommu_dev_data *dev_data, *alias_data;
 	u16 devid = pci_dev_id(pdev);
+	int ret = 0;
 
 	if (devid == alias)
 		return 0;
@@ -361,13 +380,27 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	if (!iommu)
 		return 0;
 
-	amd_iommu_set_rlookup_table(iommu, alias);
-	dev_table = get_dev_table(iommu);
-	memcpy(dev_table[alias].data,
-	       dev_table[devid].data,
-	       sizeof(dev_table[alias].data));
+	/* Copy the data from pdev */
+	dev_data = dev_iommu_priv_get(&pdev->dev);
+	if (!dev_data) {
+		pr_err("%s : Failed to get dev_data for 0x%x\n", __func__, devid);
+		ret = -EINVAL;
+		goto out;
+	}
+	get_dte256(iommu, dev_data, &new);
 
-	return 0;
+	/* Setup alias */
+	alias_data = find_dev_data(iommu, alias);
+	if (!alias_data) {
+		pr_err("%s : Failed to get alias dev_data for 0x%x\n", __func__, alias);
+		ret = -EINVAL;
+		goto out;
+	}
+	update_dte256(iommu, alias_data, &new);
+
+	amd_iommu_set_rlookup_table(iommu, alias);
+out:
+	return ret;
 }
 
 static void clone_aliases(struct amd_iommu *iommu, struct device *dev)
@@ -640,6 +673,12 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 		return -ENOMEM;
 
 	dev_data->dev = dev;
+
+	/*
+	 * The dev_iommu_priv_set() needes to be called before setup_aliases.
+	 * Otherwise, subsequent call to dev_iommu_priv_get() will fail.
+	 */
+	dev_iommu_priv_set(dev, dev_data);
 	setup_aliases(iommu, dev);
 
 	/*
@@ -653,8 +692,6 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
 	}
 
-	dev_iommu_priv_set(dev, dev_data);
-
 	return 0;
 }
 
@@ -685,10 +722,13 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 static void dump_dte_entry(struct amd_iommu *iommu, u16 devid)
 {
 	int i;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dev_table_entry dte;
+	struct iommu_dev_data *dev_data = find_dev_data(iommu, devid);
+
+	get_dte256(iommu, dev_data, &dte);
 
 	for (i = 0; i < 4; ++i)
-		pr_err("DTE[%d]: %016llx\n", i, dev_table[devid].data[i]);
+		pr_err("DTE[%d]: %016llx\n", i, dte.data[i]);
 }
 
 static void dump_command(unsigned long phys_addr)
-- 
2.34.1


